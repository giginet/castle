#!/usr/bin/env bash

month=$(date +"%Y/%m")

monthly_cost=$(ccusage monthly --json | jq -r '.monthly[-1].modelBreakdowns | map(.cost) | add | tonumber')

daily_cost=$(ccusage --daily --json | jq -r '.daily[-1].totalCost')

printf "💰 Today: \$%.2f | %s: \$%.2f\n" "$daily_cost" "$month" "$monthly_cost"
