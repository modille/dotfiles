#!/usr/bin/env bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'
RESET='\033[0m'

# Read JSON input from stdin
input=$(cat)

# Extract information from JSON input
model=$(echo "$input" | jq -r '.model.display_name // "Unknown Model"')
output_style=$(echo "$input" | jq -r '.output_style.name // "default"')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // "."')
cost=$(printf '%.2f' "$(echo "$input" | jq -r '.cost.total_cost_usd // 0')")

# Get context usage percentage
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0 | floor')

# Get project name (current directory name)
project=$(basename "$current_dir")

# Get git branch
git_branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "no-git")

# Build statusline with colors
statusline=""
statusline+="${BLUE}📁 ${project}${RESET}"
statusline+=" ${WHITE}|${RESET} "
statusline+="${GREEN}🌿 ${git_branch}${RESET}"
statusline+=" ${WHITE}|${RESET} "
statusline+="${MAGENTA}🧠 ${model}${RESET}"
statusline+=" ${WHITE}|${RESET} "
statusline+="${YELLOW}🎨 ${output_style}${RESET}"
statusline+=" ${WHITE}|${RESET} "
if [ "$used_pct" -gt 40 ]; then
    statusline+="${RED}📊 ${used_pct}%${RESET}"
else
    statusline+="${CYAN}📊 ${used_pct}%${RESET}"
fi
statusline+=" ${WHITE}|${RESET} "
statusline+="${YELLOW}💵 ${cost}${RESET}"

echo -e "$statusline"
