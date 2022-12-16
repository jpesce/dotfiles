#!/bin/sh

# Golden ratio split 📐
# Left pane = a, right pane = b, a+b -> a as b -> a
# a+b ~ 1.618, a = 1, b ~ 0.618, b ~ 38.19%
golden_ratio_split() {
  session_name=$1
  window_name=$2
  path=$3
  number_of_panes=$4

  if [[ $number_of_panes -lt 0 || $number_of_panes -gt 3 ]]; then
    echo "Golden ratio split number of panes must be 1, 2 or 3"
    exit 1
  fi

  if [ $number_of_panes -gt 1 ]; then
    tmux split-window -h -l 38% -t "=$session_name:=$window_name" -c $path
  fi
  if [ $number_of_panes -eq 3 ]; then
    tmux split-window -v -t "=$session_name:=$window_name" -c $path
  fi
}

