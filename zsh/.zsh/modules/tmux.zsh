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

alias tmux-vtex="${TMUX_SESSIONS_DIR}/vtex.sh"
# ...
# }}}
