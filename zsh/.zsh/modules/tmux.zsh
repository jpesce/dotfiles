# tmux {{{
# Only activate if inside tmux
if [[ -n "$TMUX" ]]; then
  function rename_session_to_git_root() {
    local git_root
    git_root=$(git rev-parse --show-toplevel 2>/dev/null) || return
    tmux rename-session "$(basename "$git_root")" 2>/dev/null
  }

  autoload -U add-zsh-hook
  add-zsh-hook chpwd rename_session_to_git_root
  rename_session_to_git_root  # Run once on shell start
fi

# Pre-configured tmux sessions
TMUX_SESSIONS_DIR="${PROJECTS_DIR}/dotfiles/tmux/sessions/"

alias t='tmux-gr'

# Create a tmux session with golden ratio layout
# Usage: tmux-gr [session] [-s session] [-n window] [-c path] [-p panes]
tmux-gr() {
  local session window dir panes=2
  local OPTIND OPTARG opt

  while getopts 's:n:c:p:' opt; do
    case $opt in
      s) session=$OPTARG ;;
      n) window=$OPTARG ;;
      c) dir=$OPTARG ;;
      p) panes=$OPTARG ;;
      *) echo "Usage: tmux-gr [-s session] [-n window] [-c path] [-p panes]" >&2; return 1 ;;
    esac
  done

  shift $((OPTIND - 1))
  [[ -z "$session" && -n "$1" ]] && session=$1

  dir=${dir:-$PWD}
  session=${session:-$(basename "$dir")}
  window=${window:-$(basename "$dir")}

  if [[ ! $panes =~ ^[1-3]$ ]]; then
    echo "tmux-gr: pane count must be 1, 2, or 3 (got $panes)" >&2
    return 1
  fi

  if ! tmux has-session -t "=$session" 2>/dev/null; then
    tmux new-session -d -s "$session" -n "$window" -c "$dir"
    source "${TMUX_SESSIONS_DIR}/golden_ratio_split.sh"
    golden_ratio_split "$session" "$window" "$dir" "$panes"
  fi

  if [[ -n "$TMUX" ]]; then
    tmux switch-client -t "=$session"
  else
    tmux attach-session -t "=$session"
  fi
}
# ...
# }}}
