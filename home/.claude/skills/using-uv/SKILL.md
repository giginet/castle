---
name: Using uv
description: Use uv instead of pip for managing and running Python packages. Use when `pip install` is denied, when adding a Python dependency, or when running a Python script or tool.
allowed-tools: Bash(uv:*)
---

# Managing Python Packages with uv

On this machine, `pip install` is blocked by a hook. Always use `uv` to add or run Python packages.

## Command Mapping

| Task | pip | uv |
|---|---|---|
| Add a dependency to the project | `pip install foo` | `uv add foo` |
| Add a dev dependency | `pip install foo` | `uv add --dev foo` |
| Remove a dependency | `pip uninstall foo` | `uv remove foo` |
| Sync from the lockfile | `pip install -r requirements.txt` | `uv sync` |
| Install directly into an existing venv | `pip install foo` | `uv pip install foo` |
| Install from requirements.txt | `pip install -r requirements.txt` | `uv pip install -r requirements.txt` |
| Use a CLI tool | `pip install foo && foo` | `uv add --dev foo && uv run foo` |
| Run a script with extra dependencies | `pip install foo && python s.py` | `uv run --with foo s.py` |
| Run a command inside the project | `python s.py` | `uv run s.py` |

## Workflow

1. Check whether `pyproject.toml` exists.
   - If it does, use `uv add` / `uv run` (this updates `uv.lock`).
   - If it does not, consider `uv init` for a new project, or use `uv run --with` for one-off work.
2. Use `uv pip install` only when a `.venv` is already activated and you need a one-off install.
3. Prefer `uv run foo.py` over `python foo.py` so you never have to worry about activating the venv.

## Notes

- `install` via `pip`, `pip3`, and `python -m pip` is always denied by the hook. `uv pip install` is allowed.
- `uvx` / `uv tool run` are denied by the hook. Add CLI tools as dev dependencies with `uv add --dev` and run them with `uv run <tool>`.
- Avoid installing into the global environment.
