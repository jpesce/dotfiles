#!/bin/sh

branch=$(git -C "$1" rev-parse --abbrev-ref HEAD 2>/dev/null)
if [ -n "${branch}" ]; then
    text=" ${branch} "
    color="#[fg=white]"

    # Ensure text is exactly 30 characters, truncating with ellipsis if needed
    if [ ${#text} -gt 30 ]; then
        text="${text:0:29}…"
    fi

    # Add spaces to the left to make it exactly 30 characters
    printf '%*s%s%s' "$((30-${#text}))" "" "$color" "$text"
else
    printf '%30s' ""
fi
