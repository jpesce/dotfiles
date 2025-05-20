# tmux {{{
# Only activate if inside tmux
if [[ -n "$TMUX" ]]; then
  function rename_session_to_git_root() {
    IS_INSIDE_GIT_REPO=$(git rev-parse --show-toplevel 2>/dev/null)

    # Only rename if we're inside a git repository
    if [[ -d "$IS_INSIDE_GIT_REPO" ]]; then
      # Get the git root directory name
      local git_repo_root_dir=$(basename $(git rev-parse --show-toplevel))
      tmux rename-session "$git_repo_root_dir" 2>/dev/null
    fi
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
