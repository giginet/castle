---
name: Committing for Private Projects
description: 現在のステージにある内容をコミット。このスキルは、ユーザーが「commit」「コミット」「コミットして」「変更をコミット」と言ったとき、またはステージされた変更でgitコミットを作成したいときに使用する。
allowed-tools: Bash(git add:*), Bash(git commit:*)
---

# コミットスキル

現在ステージされている変更に対して、適切なコミットメッセージを作成してコミットを実行する。

## ワークフロー

1. `git diff --staged` で現在のステージされた変更を確認する
2. 変更内容を分析し、簡潔なコミットメッセージを英語で作成する
3. Co-Authored-By を含めてコミットを実行する

## コミットメッセージのガイドライン

- コミットメッセージは英語で記述する
- 件名は簡潔に（50文字以下）
- 命令形を使用する（例: "Add feature"、"Added feature" ではない）
- 「何を」「なぜ」に焦点を当て、「どのように」は省略する

## コミットコマンド

必ず Co-Authored-By トレーラーを含める：

```bash
git commit -m "$(cat <<'EOF'
<コミットメッセージ>

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>
EOF
)"
```
