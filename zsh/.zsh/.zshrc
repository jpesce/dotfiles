# ---- Options
# Use colors on zsh commands by name
autoload colors && colors
# Use VI mode and set vim as the default editor
bindkey -v
export EDITOR=vim
# Completion
autoload -Uz compinit && compinit
setopt AUTO_MENU
zstyle ':completion:*' menu yes select
# Show dotfiles in completion
setopt globdots
# Case-insensitive completion
setopt NO_CASE_GLOB
# Enter directory even without typing cd
setopt AUTO_CD
# Store history in file
HISTFILE=$ZDOTDIR/.zsh_history
# See https://scriptingosx.com/2019/06/moving-to-zsh-part-3-shell-options/
setopt EXTENDED_HISTORY SHARE_HISTORY APPEND_HISTORY INC_APPEND_HISTORY HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS HIST_FIND_NO_DUPS HIST_REDUCE_BLANKS
SAVEHIST=100000
HISTSIZE=20000
# Try to correct commands
setopt CORRECT CORRECT_ALL

# ---- Theme
# Enable calling functions in PROMPT. Required for the theme.
setopt PROMPT_SUBST
source $ZDOTDIR/themes/common/common.zsh-theme

## ---- Plugins
# Suggest completion
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# Highlight commands
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Change highlight colors
# https://github.com/zsh-users/zsh-syntax-highlighting/tree/master/highlighters/main
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
ZSH_HIGHLIGHT_STYLES[builtin]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[alias]=fg=none,bold


# ---- Locales
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ---- Paths
# Homebrew sbin
export PATH="/usr/local/sbin:$PATH"
# PostgreSQL
export PATH=$PATH:/Library/PostgreSQL/12/bin
# Rails in dev mode by default
export RAILS_ENV=development
# Use homebrew open SSL instead of libressl
export PATH=/usr/local/opt/openssl/bin:$PATH
# Add openssl lib to path
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

# ---- Alias
alias ..='cd ..'
alias cd..='cd ..'
alias c='clear'
# LS Color code (see: https://gist.github.com/thomd/7667642)
LS_COLORS='fi=0:di=34:ln=3:pi=0:so=0:bd=0:cd=0:or=31:mi=31:ex=32:ow=31'
export LS_COLORS
# Use coreutils ls (gls)
alias l='gls --color --human-readable --group-directories-first --literal'
alias ll='gls --color --human-readable --group-directories-first --literal -l --almost-all --time-style="+%y-%m-%d %H:%M"'
alias grep='grep  --color=auto'

alias restartaudio='sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod'

# If installed, load rbenv when terminal starts
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
