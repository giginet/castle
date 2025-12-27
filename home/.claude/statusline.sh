#!/usr/bin/env bash
ccusage monthly --json | jq -r '.monthly[-1].modelBreakdowns | map(.cost) | add | tonumber' | awk '{ printf("💰 $%.2f\n", $1) }'
