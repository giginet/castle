#!/usr/bin/env bash
# render_scene.sh — Godot 4 のシーンを Movie Maker モードで N フレーム実行し、最終フレームを PNG として保存する。
#
# 使い方:
#   render_scene.sh [--project DIR] [--scene res://path.tscn | --script res://path.gd]
#                   [--frames N] [--out FILE.png] [--keep-frames] [--no-import] [-- <godot 追加引数>]
#
# 既定値: --project . / メインシーン / --frames 3 / --out <project>/.agent/render.png
# 環境変数 GODOT で実行ファイルを指定できる（未指定なら PATH と /Applications を探す）。
set -euo pipefail

usage() { sed -n '2,10p' "$0"; }

PROJECT="."
SCENE=""
SCRIPT=""
FRAMES=3
OUT=""
KEEP=0
DO_IMPORT=1
EXTRA=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project) PROJECT="$2"; shift 2 ;;
    --scene) SCENE="$2"; shift 2 ;;
    --script) SCRIPT="$2"; shift 2 ;;
    --frames) FRAMES="$2"; shift 2 ;;
    --out) OUT="$2"; shift 2 ;;
    --keep-frames) KEEP=1; shift ;;
    --no-import) DO_IMPORT=0; shift ;;
    --) shift; EXTRA=("$@"); break ;;
    -h|--help) usage; exit 0 ;;
    *) echo "unknown argument: $1" >&2; usage >&2; exit 2 ;;
  esac
done

# --- Godot 実行ファイルを探す
find_godot() {
  if [[ -n "${GODOT:-}" ]]; then echo "$GODOT"; return; fi
  for c in godot godot4 Godot; do
    if command -v "$c" >/dev/null 2>&1; then command -v "$c"; return; fi
  done
  for app in /Applications/Godot.app /Applications/Godot*.app "$HOME"/Applications/Godot*.app; do
    if [[ -x "$app/Contents/MacOS/Godot" ]]; then echo "$app/Contents/MacOS/Godot"; return; fi
  done
  echo "Godot executable not found. Set GODOT=/path/to/godot" >&2
  exit 1
}
GODOT_BIN="$(find_godot)"

PROJECT="$(cd "$PROJECT" && pwd)"
if [[ ! -f "$PROJECT/project.godot" ]]; then
  echo "project.godot not found in $PROJECT" >&2; exit 1
fi
if [[ -z "$OUT" ]]; then OUT="$PROJECT/.agent/render.png"; fi
case "$OUT" in /*) ;; *) OUT="$PWD/$OUT" ;; esac
OUT_DIR="$(dirname "$OUT")"
mkdir -p "$OUT_DIR"
# 出力先がプロジェクト内なら .gdignore を置き、Godot が PNG をリソースとして取り込まないようにする
case "$OUT_DIR" in "$PROJECT"/*) touch "$OUT_DIR/.gdignore" ;; esac

# --- 新しいスクリプト (class_name) やアセットを認識させるためのインポート走査
if [[ "$DO_IMPORT" -eq 1 ]]; then
  "$GODOT_BIN" --headless --path "$PROJECT" --import >/dev/null 2>&1 || true
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

ARGS=(--path "$PROJECT" --position 0,0 --write-movie "$TMP/frame.png" --quit-after "$FRAMES")
if [[ -n "$SCRIPT" ]]; then ARGS+=(-s "$SCRIPT"); fi
if [[ -n "$SCENE" ]]; then ARGS+=(--scene "$SCENE"); fi
ARGS+=("${EXTRA[@]+"${EXTRA[@]}"}")

set +e
"$GODOT_BIN" "${ARGS[@]}" 2>&1 | sed 's/\x1b\[[0-9;]*m//g' > "$TMP/godot.log"
set -e

# スクリプトエラー等は要約して標準エラーに出す（画像は出ていれば成功扱い）
ERR_LINES="$(grep -E "SCRIPT ERROR|^ERROR|Parse Error|Cannot|Failed" "$TMP/godot.log" || true)"
if [[ -n "$ERR_LINES" ]]; then
  echo "--- godot errors/warnings:" >&2
  echo "$ERR_LINES" | head -20 >&2
fi

LAST="$(ls "$TMP"/frame*.png 2>/dev/null | sort | tail -1 || true)"
if [[ -z "$LAST" ]]; then
  echo "no frame was written. Movie Maker needs a GUI session (not --headless) and a valid scene." >&2
  echo "--- godot log:" >&2
  tail -30 "$TMP/godot.log" >&2
  exit 1
fi

cp "$LAST" "$OUT"
COUNT="$(ls "$TMP"/frame*.png | wc -l | tr -d ' ')"
if [[ "$KEEP" -eq 1 ]]; then
  FRAMES_DIR="${OUT%.png}_frames"
  rm -rf "$FRAMES_DIR"; mkdir -p "$FRAMES_DIR"
  cp "$TMP"/frame*.png "$FRAMES_DIR/"
fi

SIZE=""
if command -v sips >/dev/null 2>&1; then
  SIZE="$(sips -g pixelWidth -g pixelHeight "$OUT" 2>/dev/null | awk '/pixel/{print $2}' | paste -sd x -)"
fi
SIM_SEC="$(awk -v f="$COUNT" 'BEGIN{printf "%.2f", f/60.0}')"
echo "rendered: $OUT (${SIZE:-?}, last of $COUNT frames, ${SIM_SEC}s simulated at 60fps)"
if [[ "$KEEP" -eq 1 ]]; then echo "frames: ${OUT%.png}_frames/"; fi
