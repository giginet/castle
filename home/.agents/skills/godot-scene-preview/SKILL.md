---
name: godot-scene-preview
description: Render a Godot 4 scene from the CLI to a PNG so the result can be inspected as an image (agentic loop for UI/scene/visual work). Use when editing Godot scenes (.tscn), UI, sprites, particles, shaders or layout and you need to see the result; or when the user says "シーンプレビュー", "レンダリングして確認", "スクリーンショットを撮って", "見た目を確認", "godot preview". Wraps `godot --write-movie` with the verified quirks of Godot 4.7.
---

# Godot シーンプレビュー

Godot 4 のシーンを CLI で数フレーム実行し、最終フレームを PNG に保存して画像として目視確認するためのハーネス。
見た目に関わる変更（シーン、UI、スプライト、パーティクル、シェーダ、レイアウト）は
**編集 → レンダリング → 画像で確認 → 修正** のループを回すこと。

## 手順

1. レンダリングする。

   ```bash
   ~/.agents/skills/godot-scene-preview/scripts/render_scene.sh --project . --scene res://ui/test.tscn --frames 3
   ```

   省略時はメインシーン、3 フレーム、出力は `<project>/.agent/render.png`。
2. 出力された PNG を画像として開いて確認する（Claude Code は Read ツール、Codex は画像表示ツール）。
3. 問題があれば修正して 1 に戻る。

## スクリプトのオプション

| オプション | 意味 |
|---|---|
| `--project DIR` | `project.godot` のあるディレクトリ（既定 `.`） |
| `--scene res://...` | 起動するシーン。省略時はプロジェクトのメインシーン |
| `--script res://...` | `SceneTree` を継承したスクリプトを `-s` で実行する（特定の状態を作って撮るとき） |
| `--frames N` | 記録するフレーム数（既定 3）。60fps 固定なので N/60 秒ぶんゲームが進む |
| `--out FILE.png` | 出力先。プロジェクト内なら同じディレクトリに `.gdignore` を自動作成 |
| `--keep-frames` | 全フレームを `<out>_frames/` に残す（アニメーションや落下の途中経過を見るとき） |
| `--no-import` | 実行前のインポート走査をスキップ（時短。新しい `class_name` やアセットを追加した直後は付けない） |
| `-- ...` | 以降を Godot にそのまま渡す（例 `-- --debug-collisions` で当たり判定を可視化） |

実行ファイルは環境変数 `GODOT`、PATH の `godot`、`/Applications/Godot.app` の順に探す。

## 直接コマンドを叩く場合

```bash
godot --path . --scene res://ui/test.tscn --write-movie .agent/render.png --quit-after 3
```

出力は `.agent/render00000000.png` から始まる連番 PNG と `.agent/render.wav`。スクリプトはこの最終フレームだけを `--out` に残す。

## Godot 4.7.2 で検証済みの注意点

- **GUI セッションが必要。** `--headless` では dummy レンダラになり、フレームは書かれない（`ERROR: Parameter "t" is null` が出て `.wav` だけ残る）。実行中はウィンドウが一瞬表示される。
- **出力サイズはプロジェクト設定の `display/window/size/viewport_width` / `viewport_height` で決まる**（未設定なら 1152×648）。`--resolution` を渡しても記録サイズは変わらない。サイズを変えたいときは `project.godot` 側を変更する。
- **`--quit-after N` はフレーム数。** Movie Maker モードは `--fixed-fps 60` が強制されるので、N=120 なら 2 秒ぶん物理・Tween・パーティクルが決定論的に進む。落下後の状態を撮るなら 120〜300 を指定する。
- **プロジェクト内に PNG を出すと Godot がインポート対象にする。** 出力ディレクトリに `.gdignore` を置くこと（スクリプトは自動で置く）。`.agent/` は `.gitignore` にも追加しておく。
- **`class_name` を追加した直後は `--import` が必要。** グローバルクラスキャッシュが更新されるまで `Could not find type` で落ちる。スクリプトは既定で走査を挟む。
- **ロジックの検証には使わない。** 合体判定やスコアなどの検証は `godot --headless --path . -s res://tests/xxx.gd` の `SceneTree` スクリプトで行い、描画確認だけをこのスキルで行う。

## 特定の状態を撮る

`--script` に `SceneTree` を継承したスクリプトを渡すと、シーンを組み立ててから撮れる。
`_initialize()` の時点では `_ready` が未実行で `@onready` 変数は null なので、状態の操作は最初の `_process` で行う。

```gdscript
extends SceneTree

var main: Node
var frame := 0

func _initialize() -> void:
	main = load("res://scenes/main.tscn").instantiate()
	root.add_child(main)

func _process(_delta: float) -> bool:
	frame += 1
	if frame == 1:
		main.spawn_something(Vector2(240, 300))  # ここで状態を作る
	return false  # true を返すと終了。通常は --quit-after に任せる
```

```bash
render_scene.sh --script res://tests/preview_state.gd --frames 90
```

`Input.parse_input_event()` でタッチやキー入力を注入すれば、操作後の画面も撮れる。
