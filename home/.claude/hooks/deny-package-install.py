#!/usr/bin/env python3
"""PreToolUse hook that denies `pip install` and `npm install`.

- pip / pip3 / python -m pip install  -> denied, use uv instead
- npm install / npm i / npm add       -> denied
- npx / uvx / uv tool run             -> denied
- uv pip install / uv add / uv run    -> allowed
"""

import json
import re
import sys

# pip install / pip3 install / python -m pip install, but NOT `uv pip install`
PIP_PATTERN = re.compile(
    r"(?<![\w-])(?<!uv\s)(?<!uv\s\s)(?:python[\d.]*\s+-m\s+)?pip3?\s+install\b"
)
# npm install / npm i / npm add (with optional flags before the subcommand)
NPM_PATTERN = re.compile(r"(?<![\w-])npm(?:\s+-[-\w]+(?:[= ]\S+)?)*\s+(?:install|i|add)\b")
# npx <pkg> / uvx <tool> / uv tool run <tool>
NPX_PATTERN = re.compile(r"(?<![\w-])npx\b")
UVX_PATTERN = re.compile(
    r"(?<![\w-])(?:uvx\b|uv(?:\s+-[-\w]+(?:[= ]\S+)?)*\s+tool\s+run\b)"
)

PIP_REASON = (
    "`pip install` is prohibited. Use uv instead:\n"
    "  - Add a dependency to the project:  uv add <package>\n"
    "  - Dev dependency:                   uv add --dev <package>\n"
    "  - Install into the current venv:    uv pip install <package>\n"
    "  - Run a script with inline deps:    uv run --with <package> script.py\n"
    "Load the `using-uv` skill for details."
)

NPX_REASON = (
    "`npx` is prohibited by user policy. Do not run packages via npx. "
    "If the tool is already installed in the project, run it via a "
    "package.json script or node_modules/.bin; otherwise ask the user."
)

UVX_REASON = (
    "`uvx` / `uv tool run` is prohibited by user policy. "
    "Do not run ad-hoc tools via uvx. Add the tool to the project with "
    "`uv add --dev <tool>` and run it with `uv run <tool>`, "
    "or ask the user."
)

NPM_REASON = (
    "`npm install` is prohibited by user policy. "
    "Do not install npm packages. If the project needs dependencies, "
    "ask the user which package manager to use (pnpm / bun / yarn)."
)


def deny(reason: str) -> None:
    json.dump(
        {
            "hookSpecificOutput": {
                "hookEventName": "PreToolUse",
                "permissionDecision": "deny",
                "permissionDecisionReason": reason,
            },
            "systemMessage": reason,
        },
        sys.stdout,
    )


def main() -> None:
    try:
        input_data = json.load(sys.stdin)
    except json.JSONDecodeError:
        return
    if input_data.get("tool_name") != "Bash":
        return
    command = input_data.get("tool_input", {}).get("command", "")

    if PIP_PATTERN.search(command):
        deny(PIP_REASON)
        return
    if NPM_PATTERN.search(command):
        deny(NPM_REASON)
        return
    if NPX_PATTERN.search(command):
        deny(NPX_REASON)
        return
    if UVX_PATTERN.search(command):
        deny(UVX_REASON)
        return


if __name__ == "__main__":
    main()
