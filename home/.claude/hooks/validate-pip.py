#!/usr/bin/env python3
"""PreToolUse hook to deny pip operations outside of a virtualenv."""

import json
import os
import re
import sys


def main():
    input_data = json.load(sys.stdin)
    command = input_data.get("tool_input", {}).get("command", "")

    # Check if the command involves pip install/uninstall/download
    if not re.search(r"\bpip[3]?\s+(install|uninstall|download)\b", command):
        return

    # Allow if the command activates a virtualenv before pip
    if re.search(r"(source|\.)\s+\S*activate\s*&&", command):
        return

    # Allow if $VIRTUAL_ENV is set in the current environment
    if os.environ.get("VIRTUAL_ENV"):
        return

    # Deny: pip without virtualenv
    result = {
        "hookSpecificOutput": {
            "permissionDecision": "deny",
        },
        "systemMessage": (
            "Running pip install in the global environment is prohibited. "
            "You must create and activate a virtualenv first. "
            "Example: source venv/bin/activate && pip install <package>"
        ),
    }
    json.dump(result, sys.stdout)


if __name__ == "__main__":
    main()
