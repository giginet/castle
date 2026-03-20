#!/usr/bin/env python3
"""Claude Code statusline script with fine-grained progress bars and gradient colors."""
import json
import os
import subprocess
import sys
import time
from datetime import datetime

data = json.load(sys.stdin)

BLOCKS = " ▏▎▍▌▋▊▉█"
R = "\033[0m"
DIM = "\033[2m"
RED = "\033[31m"


def gradient(pct: float) -> str:
    if pct < 50:
        r = int(pct * 5.1)
        return f"\033[38;2;{r};200;80m"
    else:
        g = int(200 - (pct - 50) * 4)
        return f"\033[38;2;255;{max(g, 0)};60m"


def bar(pct: float, width: int = 10) -> str:
    pct = min(max(pct, 0), 100)
    filled = pct * width / 100
    full = int(filled)
    frac = int((filled - full) * 8)
    b = "█" * full
    if full < width:
        b += BLOCKS[frac]
        b += "░" * (width - full - 1)
    return b


def fmt(label: str, pct: float) -> str:
    p = round(pct)
    return f"{label} {gradient(pct)}{bar(pct)} {p}%{R}"


# Line 1: cwd, git branch, model
cwd_path = data.get("cwd") or data.get("workspace", {}).get("current_dir") or ""
cwd = os.path.basename(cwd_path) if cwd_path else ""

git_branch = ""
if cwd_path:
    try:
        result = subprocess.run(
            ["git", "branch", "--show-current"],
            cwd=cwd_path, capture_output=True, text=True, timeout=3
        )
        git_branch = result.stdout.strip()
    except Exception:
        pass

if git_branch:
    if cwd == git_branch:
        parts_line1 = f" {git_branch}"
    else:
        parts_line1 = f" {cwd}({git_branch})"
elif cwd:
    parts_line1 = f" {cwd}"
else:
    parts_line1 = ""

model = data.get("model", {}).get("display_name") or data.get("model", {}).get("id") or ""
if model:
    parts_line1 += f" | 󰚩 {model}"

print(parts_line1)

# Line 2: context + rate limit (Pattern 4 style)
gauges = []

ctx = data.get("context_window", {})
used_pct = ctx.get("used_percentage")
if used_pct is None:
    usage = ctx.get("current_usage", {})
    input_tokens = usage.get("input_tokens", 0)
    cache_creation = usage.get("cache_creation_input_tokens", 0)
    cache_read = usage.get("cache_read_input_tokens", 0)
    context_size = ctx.get("context_window_size", 0)
    total = input_tokens + cache_creation + cache_read
    if total > 0 and context_size > 0:
        used_pct = total * 100 / context_size

if used_pct is not None:
    gauges.append(fmt("󰍛", used_pct))

rate_5h = data.get("rate_limits", {}).get("five_hour", {})
rate_5h_pct = rate_5h.get("used_percentage")
resets_at = rate_5h.get("resets_at")

if rate_5h_pct is not None:
    if rate_5h_pct >= 100:
        remaining = ""
        if resets_at:
            diff = int(resets_at - time.time())
            if diff > 0:
                h, m = diff // 3600, (diff % 3600) // 60
                remaining = f" resets in {h}h{m}m"
        gauges.append(f"{RED}⚠ Rate limit exceeded{remaining}{R}")
    else:
        gauges.append(fmt("5h", rate_5h_pct))

if gauges:
    print(f" {DIM}│{R} ".join(gauges))

# Line 3: cost
month = datetime.now().strftime("%Y/%m")
try:
    r = subprocess.run(
        ["ccusage", "monthly", "--json"],
        capture_output=True, text=True, timeout=10
    )
    monthly_data = json.loads(r.stdout)
    monthly_cost = sum(
        m.get("cost", 0)
        for m in monthly_data.get("monthly", [{}])[-1].get("modelBreakdowns", [])
    )
except Exception:
    monthly_cost = 0.0

try:
    r = subprocess.run(
        ["ccusage", "--daily", "--json"],
        capture_output=True, text=True, timeout=10
    )
    daily_data = json.loads(r.stdout)
    daily_cost = daily_data.get("daily", [{}])[-1].get("totalCost", 0)
except Exception:
    daily_cost = 0.0

print(f" Today: ${daily_cost:.2f} | {month}: ${monthly_cost:.2f}")
