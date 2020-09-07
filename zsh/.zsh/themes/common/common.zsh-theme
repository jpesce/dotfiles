# Prompt symbol
COMMON_PROMPT_SYMBOL="|"

# Colors
COMMON_COLORS_HOST_ME=green
COMMON_COLORS_HOST_AWS_VAULT=yellow
COMMON_COLORS_CURRENT_DIR=8
COMMON_COLORS_RETURN_STATUS_TRUE=8
COMMON_COLORS_RETURN_STATUS_FALSE=red
COMMON_COLORS_GIT_STATUS_DEFAULT=8
COMMON_COLORS_GIT_STATUS_STAGED=red
COMMON_COLORS_GIT_STATUS_UNSTAGED=yellow
COMMON_COLORS_GIT_PROMPT_SHA=green
COMMON_COLORS_BG_JOBS=yellow

# Left Prompt
 PROMPT='$(common_host)$(common_current_dir)$(common_bg_jobs)$(common_return_status)'

# Right Prompt
 RPROMPT='$(common_git_status)'

# Prompt with current SHA
# PROMPT='$(common_host)$(common_current_dir)$(common_bg_jobs)$(common_return_status)'
# RPROMPT='$(common_git_status) $(git_prompt_short_sha)'

# Host
common_host() {
  if [[ -n $SSH_CONNECTION ]]; then
    me="%n@%m"
  elif [[ $LOGNAME != $USER ]]; then
    me="%n"
  fi
  if [[ -n $me ]]; then
    echo "%{$fg[$COMMON_COLORS_HOST_ME]%}$me%{$reset_color%}:"
  fi
  if [[ $AWS_VAULT ]]; then
    echo "$fg[$COMMON_COLORS_HOST_AWS_VAULT]%}$AWS_VAULT%{$reset_color%} "
  fi
}

# Show current directory relative to git repository
common_current_dir() {
  if [[ -d $(git rev-parse --show-toplevel 2>/dev/null) ]]; then
    # We're in a git repo
    BASE=".../$(basename $(git rev-parse --show-toplevel))"
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
  echo -n "%F{$COMMON_COLORS_CURRENT_DIR}$PROMPT_PATH "
}

# Prompt symbol
common_return_status() {
  echo -n "%(?.%F{$COMMON_COLORS_RETURN_STATUS_TRUE}.%F{$COMMON_COLORS_RETURN_STATUS_FALSE})$COMMON_PROMPT_SYMBOL%f "
}

# Git status
common_git_status() {
    local message=""
    local message_color="%F{$COMMON_COLORS_GIT_STATUS_DEFAULT}"

    # https://git-scm.com/docs/git-status#_short_format
    local staged=$(git status --porcelain 2>/dev/null | grep -e "^[MADRCU]")
    local unstaged=$(git status --porcelain 2>/dev/null | grep -e "^[MADRCU? ][MADRCU?]")

    if [[ -n ${staged} ]]; then
        message_color="%F{$COMMON_COLORS_GIT_STATUS_STAGED}"
    elif [[ -n ${unstaged} ]]; then
        message_color="%F{$COMMON_COLORS_GIT_STATUS_UNSTAGED}"
    fi

    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -n ${branch} ]]; then
        message+="${message_color}${branch}%f"
    fi

    echo -n "${message}"
}

# Git prompt SHA
ZSH_THEME_GIT_PROMPT_SHA_BEFORE="%{%F{$COMMON_COLORS_GIT_PROMPT_SHA}%}"
ZSH_THEME_GIT_PROMPT_SHA_AFTER="%{$reset_color%} "

# Background Jobs
common_bg_jobs() {
  bg_status="%{$fg[$COMMON_COLORS_BG_JOBS]%}%(1j.↓%j .)"
  echo -n $bg_status
}
