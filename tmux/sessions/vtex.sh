#!/bin/sh

# Force script to run from the base directory to avoid relative path issues
if [[ $BASH_SOURCE = */* ]]; then cd -- "${BASH_SOURCE%/*}/"; fi

source ./golden_ratio_split.sh

SESSION_NAME="vtex"

tmux has-session -t $SESSION_NAME 2> /dev/null
if [ $? -eq 0 ]; then has_session=1; else has_session=0; fi

if [[ has_session -eq 0 ]]; then
  window_name="oficina"
  window_path="/Users/joaopesce/Projects/oficina/oficina-vtex-theme"
  # Create detached session (will attach later)
  tmux new-session -d -s $SESSION_NAME -n $window_name -c $window_path
  golden_ratio_split $SESSION_NAME $window_name $window_path 3

  window_name="simples"
  window_path="/Users/joaopesce/Projects/simples/simples-store-theme"
  # Create detached window
  tmux new-window -d -t "=$SESSION_NAME" -n $window_name -c $window_path
  golden_ratio_split $SESSION_NAME $window_name $window_path 3

  window_name="app"
  window_path="/Users/joaopesce/Projects"
  # Create detached window
  tmux new-window -d -t "=$SESSION_NAME" -n $window_name -c $window_path
  golden_ratio_split $SESSION_NAME $window_name $window_path 3
fi

if [[ "$TERM_PROGRAM" != "tmux" ]]; then
  # If outside tmux, attach to session
  tmux attach-session -t $SESSION_NAME
else
  # If inside tmux, switch to session
  tmux switch-client -t $SESSION_NAME
fi
