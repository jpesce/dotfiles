# Add a new line before each prompt, except the first
# And refresh tmux to update status bar
precmd() {
  [[ "$TERM_PROGRAM" = tmux ]] && tmux refresh-client -S
  precmd() {
    [[ "$TERM_PROGRAM" = tmux ]] && tmux refresh-client -S
    echo
  }
}

# Enable calling functions in PROMPT (required for the theme)
setopt PROMPT_SUBST

# Prompt symbol
ESSENTIAL_PROMPT_SYMBOL="•"

# Colors
ESSENTIAL_COLORS_CURRENT_DIR=none
ESSENTIAL_COLORS_RETURN_STATUS_TRUE=16
ESSENTIAL_COLORS_RETURN_STATUS_FALSE=red
ESSENTIAL_COLORS_BG_JOBS=none
ESSENTIAL_COLORS_GIT_STATUS=8

# Left Prompt
PROMPT='%B$(essential_return_status)$(essential_current_dir) ❯%b  '

# Right Prompt
RPROMPT='$(essential_bg_jobs)' # $(essential_git_status)'

# Cache git info on directory change instead of every prompt render
__essential_git_cache=()

_essential_update_git_info() {
  local toplevel
  toplevel=$(git rev-parse --show-toplevel 2>/dev/null) || { __essential_git_cache=(); return }
  __essential_git_cache=(
    "$toplevel"
    "$(basename "$toplevel")"
    "$(git rev-parse --show-prefix 2>/dev/null)"
  )
}

# Lightweight precmd check: only re-run the full update if git state changed
_essential_validate_git_cache() {
  if [[ -n "$GIT_DIR" ]]; then
    # GIT_DIR overrides — just check if it still/now exists
    if [[ -n "${__essential_git_cache[1]}" ]]; then
      [[ -e "$GIT_DIR" ]] || _essential_update_git_info
    else
      [[ -e "$GIT_DIR" ]] && _essential_update_git_info
    fi
  elif [[ -n "${__essential_git_cache[1]}" ]]; then
    # Had a cached repo — verify .git still exists
    [[ -e "${__essential_git_cache[1]}/.git" ]] || _essential_update_git_info
  else
    # No cache — walk up to check if a repo was initialized above us
    local dir="$PWD"
    while [[ "$dir" != "/" ]]; do
      if [[ -e "$dir/.git" ]]; then
        _essential_update_git_info
        break
      fi
      dir="${dir:h}"
    done
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd _essential_update_git_info
add-zsh-hook precmd _essential_validate_git_cache
_essential_update_git_info  # run once at startup

# Show current directory relative to git repository
essential_current_dir() {
  if [[ -n "${__essential_git_cache[1]}" ]]; then
    local base="—/${__essential_git_cache[2]}"
    if [[ "$PWD" = "${__essential_git_cache[1]}" ]]; then
      PROMPT_PATH="$base"
    else
      PROMPT_PATH="$base/${__essential_git_cache[3]%/}"
    fi
  else
    PROMPT_PATH="%~"
  fi
  echo -n "%F{$ESSENTIAL_COLORS_CURRENT_DIR}$PROMPT_PATH%f"
}

# Git status
essential_git_status() {
  local message=""
  local message_color="%F{$ESSENTIAL_COLORS_GIT_STATUS}"

    # https://git-scm.com/docs/git-status#_short_format
    local porcelain
    porcelain=$(git status --porcelain 2>/dev/null) || return
    local staged=$(echo "$porcelain" | grep -e "^[MADRCU]")
    local unstaged=$(echo "$porcelain" | grep -e "^[MADRCU? ][MADRCU?]")

    if [[ -n ${staged} ]]; then
      staged_symbol=""
    elif [[ -n ${unstaged} ]]; then
      staged_symbol="!"
    fi

    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -n ${branch} ]]; then
      message+="${message_color}${staged_symbol}${branch}%f "
    fi

    echo -n "${message}"
  }

# Prompt symbol
essential_return_status() {
  echo -n "%(?.%F{$ESSENTIAL_COLORS_RETURN_STATUS_TRUE}.%F{$ESSENTIAL_COLORS_RETURN_STATUS_FALSE})$ESSENTIAL_PROMPT_SYMBOL%f "
}

# Background Jobs
essential_bg_jobs() {
  echo -n "%F{$ESSENTIAL_COLORS_BG_JOBS}%(1j.↓%j .)%f"
}