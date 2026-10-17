---
name: Using ghq
description: Clone GitHub repositories locally with `ghq get` instead of reading their code through the API or the web. Use when the user shares a GitHub URL or `owner/repo`, asks to "look at", "check", "investigate" or "read the source of" a repository or library, or whenever about to fetch repository files via WebFetch (github.com, raw.githubusercontent.com), `gh api repos/.../contents`, `gh repo clone`, or `git clone`. Also triggers on "ghq", "リポジトリを見て", "実装を調べて", "ソースを読んで".
allowed-tools: Bash(ghq get:*), Bash(ghq list:*), Bash(ghq root:*)
---

# Referencing GitHub Repositories with ghq

On this machine, repositories are managed by `ghq` under `~/.ghq/<host>/<owner>/<repo>`. Whenever the contents of a GitHub repository are needed, clone it with `ghq get` and read it from the local filesystem. Do not fetch source files through the GitHub API or over HTTP.

A local clone is searchable with Grep/Glob, shows the full project context, costs no API rate limit, and stays available for later sessions.

## Command Mapping

| Instead of | Use |
|---|---|
| WebFetch `https://github.com/owner/repo/blob/...` | `ghq get owner/repo`, then Read |
| WebFetch `https://raw.githubusercontent.com/...` | `ghq get owner/repo`, then Read |
| `gh api repos/owner/repo/contents/...` | `ghq get owner/repo`, then Read |
| `gh api repos/owner/repo/git/trees/...` | `ghq get owner/repo`, then Glob |
| `gh search code --repo owner/repo` | `ghq get owner/repo`, then Grep |
| `git clone` / `gh repo clone` into a temp dir | `ghq get owner/repo` |

## Workflow

1. Resolve the repository to `owner/repo`. Full URLs (`https://github.com/owner/repo`) are also accepted by `ghq get`; strip any `/blob/...` or `/tree/...` suffix first.
2. Check whether it is already cloned:
   ```bash
   ghq list -p -e owner/repo
   ```
   If a path is printed, use it as is and skip step 3.
3. Clone it:
   ```bash
   ghq get --silent owner/repo
   ```
   - For very large repositories, add `--partial blobless` to keep the full history while downloading file contents lazily. Avoid `--shallow`; it breaks `git log` and `git blame`.
   - Never pass `-p` (SSH). SSH access triggers a 1Password prompt; the default HTTPS clone does not.
4. Get the local path with `ghq list -p -e owner/repo` and explore it with Read, Grep and Glob.
5. Refer to files by their local path when reporting findings. Add the GitHub URL as well when the user will likely want to open it in a browser.

## Treat Clones as Read-Only

`~/.ghq` is the user's real workspace, not a cache. An existing clone may have uncommitted changes or a checked-out feature branch.

- Do not edit, commit, `git checkout`, `git pull`, `git reset` or `git stash` inside a clone unless the user asked to work on that repository.
- Never delete a clone (`ghq rm`, `rm -rf`).
- To read another branch, tag or commit without touching the working tree:
  ```bash
  git -C <path> fetch --tags origin        # safe: updates remote-tracking refs only
  git -C <path> show v1.2.3:Sources/Foo.swift
  git -C <path> grep -n "pattern" origin/main -- Sources/
  git -C <path> log --oneline origin/main -- path/to/file
  ```
- An existing clone may be stale. When freshness matters, run `git -C <path> fetch origin` and read from `origin/<default-branch>` rather than pulling. Mention it if the working tree is behind or on a non-default branch.

## When the GitHub API Is Still the Right Tool

Use `gh` for data that does not live in the git repository:

- Issues, pull requests, reviews, discussions
- Releases, release assets, Actions runs and logs
- Repository metadata (stars, topics, default branch)
- A quick look at one known file (e.g. a single README or manifest) when nothing else from the repository is needed. As soon as a second file, a search, or surrounding context is needed, clone instead.
- Code search across many repositories or a whole organization, when the target repository is not yet known. Once a repository is identified, clone it and continue locally.

## Notes

- Non-GitHub hosts work the same way: `ghq get gitlab.com/owner/repo`.
- Private repositories clone over HTTPS using the `gh` credential helper. If cloning fails with an authentication error, report it to the user instead of falling back to the API.
- For a dependency already vendored in the current project (`.build/checkouts`, `node_modules`, `Pods`, etc.), prefer that copy: it matches the version actually in use.
