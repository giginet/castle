---
name: Fetching PR Reviews
description: 現在のブランチに関連するPRのレビューコメントを取得する。このスキルは、ユーザーが「PRレビュー」「レビューコメント」「PR feedback」「review comments」と言ったとき、または現在のPRに対するレビューを確認したいときに使用する。
allowed-tools: Bash(gh pr view:*), Bash(gh api:*)
---

# PR レビューコメント取得スキル

現在のブランチに関連するPull Requestのレビューコメントを取得して表示する。

## ワークフロー

### 1. 現在のブランチに関連するPRを特定

```bash
gh pr view --json number,title,url
```

PRが見つからない場合は、ユーザーにPRがまだ作成されていないことを伝える。

### 2. レビューの取得

PRのレビュー（Approve/Request Changes/Comment）を取得する：

```bash
gh pr view --json reviews --jq '.reviews[] | "[\(.state)] \(.author.login): \(.body)"'
```

### 3. インラインコメント（レビューコメント）の取得

コード行に対するインラインコメントを取得する：

```bash
gh pr view --json reviewDecision,comments --jq '.comments[] | "\(.author.login) (\(.path):\(.line // "general")): \(.body)"'
```

より詳細な情報が必要な場合はAPIを直接使用：

```bash
gh api repos/{owner}/{repo}/pulls/{pr_number}/comments --jq '.[] | "\(.user.login) - \(.path):\(.line)\n\(.body)\n---"'
```

### 4. 結果の整理と表示

取得したレビューコメントを以下の形式で整理して表示する：

- レビューの状態（Approved, Changes Requested, Commented）
- レビュアー名
- コメント内容
- 対象ファイルと行番号（インラインコメントの場合）

未解決のコメントがあれば、それを強調して表示する。
