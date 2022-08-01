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
source $ZDOTDIR/plugins/ohmyzsh/plugins/vi-mode/vi-mode.plugin.zsh
# V to edit command in vi
bindkey -M vicmd 'V' edit-command-line

# Set nvim as the default editor
export EDITOR=nvim
# }}}

# Completion {{{
# Suggest inline completion before typing tab
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Load completions
# Homebrew completions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
# Faster git completion
FPATH="${ZDOTDIR}/plugins/ohmyzsh/plugins/gitfast:${FPATH}"

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

# Strings -> 16 (accent)
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=16
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=fg=16
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=16
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=16

# Recognized expressions -> bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[alias]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[global-alias]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=none,bold
ZSH_HIGHLIGHT_STYLES[globbing]=fg=none,bold
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

# Dumb loading (use this instead of the plugin if any problem arises):
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# zsh-nvm plugin
# - Install nvm if not currently installed
# - Upgrade nvm without losing node versions with `nvm upgrade`
# - Only load nvm when using nvm or its installed packages or nvim (for js lsp)
export NVM_LAZY=true
export NVM_LAZY_CMD=('nvim')
source $ZDOTDIR/plugins/ohmyzsh/plugins/nvm/nvm.plugin.zsh
# source $ZDOTDIR/plugins/ohmyzsh/plugins/zsh-nvm/zsh-nvm.plugin.zsh
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
# Directory -> color 16 (custom accent color)
LS_COLORS='fi=0:di=01;38;5;16:ln=3:pi=0:so=0:bd=0:cd=0:or=31:mi=31:ow=31:ex=1'
export LS_COLORS

# Use coreutils ls (gls)
alias ls='gls --color --human-readable --group-directories-first --literal'
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

# Fuzzy Finder functions {{{
# FZF theme
export FZF_DEFAULT_OPTS="
  --color=fg:-1,bg:-1,hl:yellow,fg+:-1,bg+:-1,hl+:yellow
  --color=gutter:black,info:black,border:white,prompt:white,pointer:15,marker:yellow,spinner:-1,header:-1
"

# Search directories
alias sd='cd $(find * -type d 2>/dev/null | fzf)'

# Search and go to projects with <CTRL+P>
function projects() {
  directory=$(\
    find ~/Projects ~/Projects/oficina ~/Projects/dotfiles -not -path '*/.*' -maxdepth 1 -type d |\
    sort | uniq |\
    fzf-tmux -p 80,85% --prompt='Project ❯ '\
  )
  # Only cd if a directory was selected
  [[ ! -z "$directory" ]] && cd $directory
}

functions __projects_widget() { projects && zle accept-line }
zle -N __projects_widget
bindkey "^P" __projects_widget

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

# ZSH-useful functions {{{
# Compile ZSH scripts
zsh-compile() {
for zfile in $ZDOTDIR/**/*.zsh(|-theme)(N-.); do
  zcompile -R ${zfile} && print -PR "%F{green}→%f %B${zfile}:%b Compiled"
done
print -P '🦾 Done with compiling.'
}

# Clean compiled files
zsh-compile-clean() {
for zfile in $ZDOTDIR/**/*.zwc; do
  rm -f ${zfile} && print -PR "%F{green}→%f %B${zfile}:%b Removed"
done
print -P '🧹 Done with cleaning.'
}

# Test zsh startup time
zsh-startup-time() {
shell=${1-$SHELL}
for i in $(seq 1 4); do /usr/bin/time $shell -i -c exit; done
}
# }}}

# vim: fdm=marker
