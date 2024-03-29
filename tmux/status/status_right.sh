#!/bin/bash

branch=$(git -C $1 rev-parse --abbrev-ref HEAD 2>/dev/null)
[[ ! -z "${branch}" ]] && text=" ${branch} "

color="#[fg=white]"

# Add space to text so it has always 30 characters
# See https://unix.stackexchange.com/a/594880 for the arcane
printf '%*s%s%s' "$((30-${#text}))" "" "$color" "$text"
