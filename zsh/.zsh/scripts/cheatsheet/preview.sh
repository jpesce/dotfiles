#!/bin/zsh
# Get an rg output such as "tmux.md:1:1:# Tmux" and show a preview of the file
# with the search term highlighted and with surrounding context

local parts=("${(@s/:/)1}")
local filename="${parts[1]}"
local line="${parts[2]}"
local searched_string="${parts[4]}"
local escaped_searched_string=$(echo "$searched_string" | sed -r 's/\-/\\-/g')

ZDOTDIR="${ZDOTDIR:-$HOME/.zsh}"

# Get the appropriate context with context extractor script
local section=$("$ZDOTDIR/scripts/cheatsheet/context_extractor/context_extractor.sh" "$filename" "$line")

# Use grep to highlight matched term
# -C: print surrounding lines around the term
# --color=always to color. GREP_COLOR: 30 = fg black; 107 = bg bright white
echo "$section" | GREP_COLOR="1;30;107" grep -C $(($FZF_PREVIEW_LINES/2)) --color=always "$escaped_searched_string"
