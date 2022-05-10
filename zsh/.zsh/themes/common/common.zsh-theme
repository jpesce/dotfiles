# Prompt symbol
COMMON_PROMPT_SYMBOL="" #"  ○"

# Colors
COMMON_COLORS_CURRENT_DIR=none
COMMON_COLORS_RETURN_STATUS_TRUE=none
COMMON_COLORS_RETURN_STATUS_FALSE=red
COMMON_COLORS_BG_JOBS=none
COMMON_COLORS_GIT_STATUS=8

# Left Prompt
 PROMPT='$(common_return_status)$(common_current_dir) ❯  '

# Right Prompt
RPROMPT='$(common_bg_jobs) $(common_git_status)'

# Show current directory relative to git repository
common_current_dir() {
  if [[ -d $(git rev-parse --show-toplevel 2>/dev/null) ]]; then
    # We're in a git repo
    BASE="—/$(basename $(git rev-parse --show-toplevel))"
    if [[ $PWD = $(git rev-parse --show-toplevel) ]]; then
        # We're in the root
        PROMPT_PATH="$BASE"
    else
        PROMPT_PATH="$BASE/$(git rev-parse --show-prefix)"
        PROMPT_PATH=${PROMPT_PATH%?} # Remove trailing `/`
    fi
  else
    PROMPT_PATH="%~"
  fi
  echo -n "%F{$COMMON_COLORS_CURRENT_DIR}$PROMPT_PATH%f"
}

# Git status
common_git_status() {
    local message=""
    local message_color="%F{$COMMON_COLORS_GIT_STATUS}"

    # https://git-scm.com/docs/git-status#_short_format
    local staged=$(git status --porcelain 2>/dev/null | grep -e "^[MADRCU]")
    local unstaged=$(git status --porcelain 2>/dev/null | grep -e "^[MADRCU? ][MADRCU?]")

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
common_return_status() {
  echo -n "%(?.%F{$COMMON_COLORS_RETURN_STATUS_TRUE}.%F{$COMMON_COLORS_RETURN_STATUS_FALSE})$COMMON_PROMPT_SYMBOL%f "
}

# Background Jobs
common_bg_jobs() {
  bg_status="%{$fg[$COMMON_COLORS_BG_JOBS]%}%(1j.↓%j .)"
  echo -n $bg_status
}
