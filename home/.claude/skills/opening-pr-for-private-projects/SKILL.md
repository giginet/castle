---
name: Opening PR for Private Projects
description: 現在の差分からPull Requestを作成する。このスキルは、ユーザーが「PR作成」「PRを開く」「プルリクエスト」「open pr」「create pr」と言ったとき、またはGitHubにPull Requestを作成したいときに使用する。
allowed-tools: Bash(gh pr create:*), Bash(git diff:*), Bash(git push:*)
---

# Pull Request 作成スキル

現在のブランチの差分からGitHub Pull Requestを作成する。

## ワークフロー

### 1. 差分の取得

特に指示がない場合、現在のブランチと `main` ブランチとの差分を取得する。`main` が見つからない場合は `master` を利用する。

```bash
git diff main...HEAD
```

### 2. PR Title / Description の作成

英語でタイトルと説明を生成する。以下のテンプレートに従って記述するため、ユーザーから対話的に「モチベーションとコンテキスト」「変更の詳細」を聞く。

```
## Motivation & Context

## Description
```

対話的に聞き取った内容は英訳し、長くても5文程度の英文にまとめる。

### 3. ブランチのPush

- origin が giginet ユーザーのものである場合は origin に push する
- そうでない場合は giginet ユーザーの fork に push する

### 4. gh コマンドを使った PR の作成

```bash
gh pr create --title "<title>" --body "<description>" --head "<head>"
```
