# Completion
# Suggest inline completion before typing tab
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Load completions
setopt AUTO_MENU
# Expand globs (*.), then default completion, then try to guess
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' menu yes select
# Case insensitive completion (lowercase letters also match uppercase)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Color files basted on LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# Show dotfiles in completion
setopt globdots

# Allow keybinds specific for menu selection
zmodload zsh/complist
# ^hjkl navigate the completion menu
bindkey -M menuselect '^h' vi-backward-char
bindkey -M menuselect '^k' vi-up-line-or-history
bindkey -M menuselect '^l' vi-forward-char
bindkey -M menuselect '^j' vi-down-line-or-history
# ^[ cancel completion
bindkey -M menuselect '^[' undo

# Completions for Homebrew and Homebrew-installed packages
if [[ -n "$HOMEBREW_PREFIX" ]]; then
  FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit
compinit -C 