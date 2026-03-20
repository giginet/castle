#!/usr/bin/env bash

json=$(cat)

cwd=$(echo "$json" | jq -r '.cwd // .workspace.current_dir // empty' | xargs basename 2>/dev/null)
git_branch=$(cd "$(echo "$json" | jq -r '.cwd // .workspace.current_dir // "."')" 2>/dev/null && git branch --show-current 2>/dev/null)
model=$(echo "$json" | jq -r '.model.display_name // .model.id // empty')

input_tokens=$(echo "$json" | jq -r '.context_window.current_usage.input_tokens // 0')
cache_creation=$(echo "$json" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')
cache_read=$(echo "$json" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
context_size=$(echo "$json" | jq -r '.context_window.context_window_size // 0')
total_context=$((input_tokens + cache_creation + cache_read))

if [ -n "$git_branch" ]; then
  if [ "$cwd" = "$git_branch" ]; then
    printf "📁 %s" "$git_branch"
  else
    printf "📁 %s(%s)" "$cwd" "$git_branch"
  fi
elif [ -n "$cwd" ]; then
  printf "📁 %s" "$cwd"
fi

if [ -n "$model" ]; then
  printf " | 🤖 %s" "$model"
fi

printf "\n"

if [ "$total_context" -gt 0 ] && [ "$context_size" -gt 0 ]; then
  usage_percent_raw=$(echo "scale=1; $total_context * 100 / $context_size" | bc)
  filled=$(echo "$total_context * 40 / $context_size" | bc)
  [ "$filled" -gt 40 ] && filled=40

  bar=""
  for i in $(seq 1 40); do
    if [ "$i" -le "$filled" ]; then
      bar="${bar}█"
    else
      bar="${bar}░"
    fi
  done

  printf "󰍛 %s %s%%\n" "$bar" "$usage_percent_raw"
elif [ "$total_context" -gt 0 ]; then
  if [ "$total_context" -ge 1000 ]; then
    printf "󰍛 %.1fK tokens\n" "$(echo "scale=1; $total_context / 1000" | bc)"
  else
    printf "󰍛 %d tokens\n" "$total_context"
  fi
fi

rate_5h=$(echo "$json" | jq -r '.rate_limits.five_hour.used_percentage // empty')
rate_5h_resets=$(echo "$json" | jq -r '.rate_limits.five_hour.resets_at // empty')

if [ -n "$rate_5h" ]; then
  if [ "$rate_5h" -ge 100 ] 2>/dev/null; then
    remaining=""
    if [ -n "$rate_5h_resets" ]; then
      now=$(date +%s)
      diff=$((rate_5h_resets - now))
      if [ "$diff" -gt 0 ]; then
        hours=$((diff / 3600))
        mins=$(( (diff % 3600) / 60 ))
        remaining=" (resets in ${hours}h${mins}m)"
      fi
    fi
    printf "\033[31m⚠ Rate limit exceeded%s\033[0m" "$remaining"
  else
    filled=$((rate_5h * 20 / 100))
    [ "$filled" -gt 20 ] && filled=20
    bar=""
    for i in $(seq 1 20); do
      if [ "$i" -le "$filled" ]; then
        bar="${bar}█"
      else
        bar="${bar}░"
      fi
    done
    printf "⏱ 5h: %s %d%%" "$bar" "$rate_5h"
  fi
fi

printf "\n"

month=$(date +"%Y/%m")
monthly_cost=$(ccusage monthly --json 2>/dev/null | jq -r '.monthly[-1].modelBreakdowns | map(.cost) | add // 0')
daily_cost=$(ccusage --daily --json 2>/dev/null | jq -r '.daily[-1].totalCost // 0')
printf "💰 Today: \$%.2f | %s: \$%.2f" "$daily_cost" "$month" "$monthly_cost"

printf "\n"
