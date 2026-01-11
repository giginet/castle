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

if [ "$total_context" -gt 0 ] && [ "$context_size" -gt 0 ]; then
  usage_percent=$(echo "scale=1; $total_context * 100 / $context_size" | bc)
  if [ "$total_context" -ge 1000 ]; then
    printf " | 📊 %.1fK/%.0fK (%.1f%%)" "$(echo "scale=1; $total_context / 1000" | bc)" "$(echo "scale=0; $context_size / 1000" | bc)" "$usage_percent"
  else
    printf " | 📊 %d/%d (%.1f%%)" "$total_context" "$context_size" "$usage_percent"
  fi
elif [ "$total_context" -gt 0 ]; then
  if [ "$total_context" -ge 1000 ]; then
    printf " | 📊 %.1fK tokens" "$(echo "scale=1; $total_context / 1000" | bc)"
  else
    printf " | 📊 %d tokens" "$total_context"
  fi
fi

month=$(date +"%Y/%m")
monthly_cost=$(ccusage monthly --json 2>/dev/null | jq -r '.monthly[-1].modelBreakdowns | map(.cost) | add // 0')
daily_cost=$(ccusage --daily --json 2>/dev/null | jq -r '.daily[-1].totalCost // 0')
printf " | 💰 Today: \$%.2f | %s: \$%.2f" "$daily_cost" "$month" "$monthly_cost"

printf "\n"
