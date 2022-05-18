# Sensible defaults {{{
# Use colors on zsh commands by name instead of color code
autoload colors && colors
# Suggest commands corrections
setopt CORRECT CORRECT_ALL
# Locales
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# }}}

# Use vi mode on shell
bindkey -v

# Set nvim as the default editor
export EDITOR=nvim

# Completion {{{
autoload -Uz compinit && compinit
setopt AUTO_MENU
zstyle ':completion:*' menu yes select
# Case insensitive completion (lowercase letters also match uppercase)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# Show dotfiles in completion
setopt globdots
# Suggest completion before typing tab
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# }}}

# History {{{
# Store history in file
HISTFILE=$ZDOTDIR/.zsh_history
# See https://scriptingosx.com/2019/06/moving-to-zsh-part-3-shell-options/
setopt EXTENDED_HISTORY SHARE_HISTORY APPEND_HISTORY INC_APPEND_HISTORY HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS HIST_FIND_NO_DUPS HIST_REDUCE_BLANKS
SAVEHIST=100000
HISTSIZE=20000
# }}}

# Visual {{{
# Enable calling functions in PROMPT (required for the theme)
setopt PROMPT_SUBST
# Set theme
source $ZDOTDIR/themes/common/common.zsh-theme

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
# }}}

# Paths {{{
# Homebrew sbin
export PATH="/usr/local/sbin:$PATH"
# Use homebrew open SSL instead of libressl
export PATH=/usr/local/opt/openssl/bin:$PATH
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
# }}}

# Node {{{
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# }}}

# Aliases {{{
# Enter directory even without typing cd
setopt AUTO_CD
alias ..='cd ..'
alias cd..='cd ..'
alias c='clear'
alias grep='grep  --color=auto'

alias vim='nvim'

# LS Colors (see: https://gist.github.com/thomd/7667642)
LS_COLORS='fi=0:di=34:ln=3:pi=0:so=0:bd=0:cd=0:or=31:mi=31:ex=32:ow=31'
export LS_COLORS

# Use coreutils ls (gls)
alias l='gls --color --human-readable --group-directories-first --literal'
alias ll='gls --color --human-readable --group-directories-first --literal -l --almost-all --time-style="+%y-%m-%d %H:%M"'

# Restart OS X audio
alias restartaudio='sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod'

# Convert mov to gif
function movtogif () {
  tempfile=.mov-to-gif-$(date +"%s").png
  ffmpeg -v quiet -i $1 -vf "scale=iw*.5:ih*.5" "${1%.mov}-resized.mov"
  ffmpeg -v quiet -stats -y -i "${1%.mov}-resized.mov" -vf fps=10,palettegen $tempfile
  ffmpeg -v quiet -stats -i "${1%.mov}-resized.mov" -i $tempfile -filter_complex "fps=10,paletteuse" "${1%.mov}.gif"
  rm $tempfile "${1%.mov}-resized.mov"
}

# Go to project's git root
alias root='cd `git rev-parse --show-toplevel`'

# Go to notes and open vim
NOTES_DIR='/Users/joaopesce/Projects/pesce.cc/source/'
alias z='cd $NOTES_DIR && nvim'

# Open vim inside cheatsheet directory with Rgi to interactively ripgrep inside it
CHEATSHEET_DIR='/Users/joaopesce/Projects/cheatsheet'
alias cheat='vim "+cd $CHEATSHEET_DIR" "+Rgi"'

# Search and go to projects
function projects () {
  directory=$(\
    find ~/Projects ~/Projects/oficina ~/Projects/dotfiles -not -path '*/.*' -maxdepth 1 -type d |\
    sort | uniq |\
    fzf-tmux -p 80,85% --color 'gutter:black,marker:yellow,pointer:black,bg+:-1,prompt:white,info:black,hl+:yellow,hl:yellow,spinner:-1' --prompt='Project ❯ '\
  )
  # Only continue if a directoy was selected
  if [[ ! -z "$directory" ]]
  then
    cd $directory
    clear
  fi
}

# Bind projects search to CTRL+P
# ^U delete corrent line
# ^M enter command
bindkey -s "^P" '^Uprojects^M'

# Easy tmux setup
TMUX_SESSIONS='/Users/joaopesce/Projects/dotfiles/tmux/sessions/'
alias tmux-vtex='$TMUX_SESSIONS/vtex-theme.sh'
alias tmux-pesce='$TMUX_SESSIONS/pesce-cc.sh'
# }}}

# vim: fdm=marker
