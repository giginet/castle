---
description: 現在の差分からPull Requestを作成する
allowed-tools: Bash(gh pr create:*), Bash(git diff:*), Bash(git push:*)
argument-hint: [description] [head]
---

現在の差分からPull Requestを作成します。

## 現在の差分の取得

特に指示がない場合、現在のブランチと`main`ブランチとの差分を取得します。`main`が見つからない場合は、`master`を利用してください。

```bash
git diff main...HEAD
```

## PR Title / Descriptionの作成

英語でタイトルと説明を生成します。以下のようなテンプレートに従って記述したいので、ユーザーから対話的に「モチベーションとコンテキスト」、「変更の詳細」を聞いてください。

```
## Motivation & Context

## Description
```

対話的に聞き取った内容は英訳し、長くても5文程度の英文にまとめてください。

## ブランチのPush

originがgiginetユーザーのものである場合はoriginにpushし、そうでない場合はgiginetユーザーのforkにpushしてください。

## ghコマンドを使ったPRの作成

```bash
gh pr create --title "<title>" --body "<description>" --head "<head>"
```
