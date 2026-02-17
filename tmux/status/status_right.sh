#!/bin/sh

branch=$(git -C "$1" rev-parse --abbrev-ref HEAD 2>/dev/null)
if [ -n "${branch}" ]; then
    printf '  %s ' "$branch"
fi
