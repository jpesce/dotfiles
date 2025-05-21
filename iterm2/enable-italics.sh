#!/bin/bash

# ---- Override the local entry for xterm-256color
# https://eddieantonio.ca/blog/2015/04/16/iterm-italics/
# Only affects local machine so remote machines still won’t be able to display italics.
# WARN: might have a problem when sshing into your mac.
infocmp xterm-256color > /tmp/xterm-256color.terminfo
# printf '\tsitm=\\E[3m, ritm=\\E[23m,\n' >> /tmp/xterm-256color.terminfo
tic /tmp/xterm-256color.terminfo

# Or if you prefere to create a new terminfo and have an ssh alias:
# https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
