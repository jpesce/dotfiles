# Sensible defaults {{{
# Use colors on zsh commands by name instead of color code
autoload colors && colors
# Suggest commands corrections
# setopt CORRECT CORRECT_ALL
# Locales
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# }}}

# vi integration {{{
# Use vi mode on prompt
bindkey -v

# Increase vi-like zsh functionality
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
# Change cursor for normal and insert mode
VI_MODE_SET_CURSOR=true
source $ZDOTDIR/plugins/vi-mode/vi-mode.plugin.zsh
# V to edit command in vi
bindkey -M vicmd 'V' edit-command-line

# Set nvim as the default editor
export EDITOR=nvim
# }}}

# Completion {{{
# Suggest inline completion before typing tab
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

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


autoload -Uz compinit
# Only check the cached .zcompdump once a day
# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2308206
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
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
# Set a custom accent color on color code 16
$ZDOTDIR/scripts/set_accent_color.sh
# Enable calling functions in PROMPT (required for the theme)
setopt PROMPT_SUBST
# Set theme
source $ZDOTDIR/themes/essential/essential.zsh-theme

# Highlight commands
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Change highlight colors
# https://github.com/zsh-users/zsh-syntax-highlighting/tree/master/docs/highlighters
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[unknown-token]=none
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
# Recognized expressions (bold)
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[alias]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[global-alias]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=none,bold
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

# Dumb loading (use this instead of the rest if any problem arises):
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Smart loading:
# Lazy load nvm
nvm() {
  echo "🚨 NVM not loaded! Loading now..."
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use # This loads nvm
  nvm $@
}

# Resolve the default node version
DEFAULT_NODE_VER="$(cat "$NVM_DIR/alias/default" 2> /dev/null || cat ~/.nvmrc 2> /dev/null)"
while [ -s "$NVM_DIR/alias/$DEFAULT_NODE_VER" ] && [ ! -z "$DEFAULT_NODE_VER" ]; do
  DEFAULT_NODE_VER="$(cat "$NVM_DIR/alias/$DEFAULT_NODE_VER")"
done

# Resolve the path to the default node version
DEFAULT_NODE_VER_PATH="$(find $NVM_DIR/versions/node -maxdepth 1 -name "v${DEFAULT_NODE_VER#v}*" | sort -rV | head -n 1)"

# Add the default node version path to PATH so we can access globally installed
# packages
if [ ! -z "$DEFAULT_NODE_VER_PATH" ]; then
  export PATH="$DEFAULT_NODE_VER_PATH/bin:$PATH"
fi
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

# Easy tmux setup
TMUX_SESSIONS='/Users/joaopesce/Projects/dotfiles/tmux/sessions/'
alias tmux-vtex='$TMUX_SESSIONS/vtex-theme.sh'
alias tmux-pesce='$TMUX_SESSIONS/pesce-cc.sh'
# }}}

# Fuzzy Finder {{{
# FZF theme
export FZF_DEFAULT_OPTS="
  --color=fg:-1,bg:-1,hl:yellow,fg+:-1,bg+:-1,hl+:yellow
  --color=gutter:black,info:black,border:white,prompt:white,pointer:15,marker:yellow,spinner:-1,header:-1
"

# Search and go to projects
function projects () {
  directory=$(\
    find ~/Projects ~/Projects/oficina ~/Projects/dotfiles -not -path '*/.*' -maxdepth 1 -type d |\
    sort | uniq |\
    fzf-tmux -p 80,85% --prompt='Project ❯ '\
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

# Grep cheatsheet directory interactively and open file when selected
ch() {
  RG_PREFIX="rg --column --line-number --no-heading --smart-case --color=always "
  RG_PREFIX+="--color=always --colors 'column:fg:white' --colors 'line:fg:white' --colors 'path:fg:green' --colors 'match:fg:black' --colors 'match:bg:15'"

  # Change to cheatsheet directory so rg output doesn't include the full path,
  # making it nicer to the eyes in fzf
  cd $CHEATSHEET_DIR

  # Start fzf searching to the argument given to ch ($1)
  location=$(\
    eval "${RG_PREFIX} '$1'" |
    fzf-tmux -p 90%,90% --prompt='Cheatsheet ❯ '\
             --bind "change:reload:$RG_PREFIX {q} || true" --ansi --phony --preview "_pc {}" \
  )

  # Only continue if an option was selected
  if [[ ! -z "$location" ]]
  then
    filename=$(echo $location | cut -d ':' -f1)
    line=$(echo $location | cut -d ':' -f2)
    column=$(echo $location | cut -d ':' -f3)
    nvim "+call cursor($line,$column)" $filename
  fi

  # Change back to previous directory
  # Don't output the path to terminal
  cd - > /dev/null }
# }}}

# vim: fdm=marker
