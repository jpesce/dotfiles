# Paths {{{
# Sets PATH, MANPATH, and INFOPATH to include Homebrew's locations
eval "$(brew shellenv)"
# }}}

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
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit
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
$ZDOTDIR/scripts/set_custom_colors.sh
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

# ASDF: General purpose version manager for tools and runtimes such as Node.js, Ruby, Python, etc. {{{
. "$(brew --prefix asdf)/libexec/asdf.sh"
# }}}

# Aliases {{{
# Enter directory even without typing cd
setopt AUTO_CD
alias ..='cd ..'
alias cd..='cd ..'
alias c='clear'
alias grep='grep  --color=auto'

# Start all *arr services
alias arr-start='open /Applications/Prowlarr.app && open /Applications/Radarr.app && (bazarr > /tmp/bazarr.log 2>&1 &) 2>/dev/null'

# Stop all *arr services
arr-stop() {
  pkill -INT -f Prowlarr
  pkill -INT -f Radarr
  pkill -INT -f "Python.*bazarr"
  
  echo "Waiting for services to terminate gracefully..."
  while pgrep -f Prowlarr > /dev/null || pgrep -f Radarr > /dev/null || pgrep -f "Python.*bazarr" > /dev/null; do
    sleep 0.1
  done
  echo "All services terminated."
}

# Bring a process to foreground by name
fgp() { fg %$(pgrep -f "$1") }

# Open nvim with clean state
alias cvim='nvim --clean'

# LS Colors (see: https://gist.github.com/thomd/7667642)
# Directory -> color 16 (custom accent color)
LS_COLORS='fi=0:di=01;38;5;16:ln=3:pi=0:so=0:bd=0:cd=0:or=31:mi=31:ow=31:ex=1'
export LS_COLORS

# LS
if command -v gls &>/dev/null; then
  # Use coreutils ls (gls) (requires `brew install coreutils`)
  alias ls='gls --color --human-readable --group-directories-first --literal'
  alias l='gls --color --human-readable --group-directories-first --literal'
  alias ll='gls --color --human-readable --group-directories-first --literal -l --almost-all --time-style="+%y-%m-%d %H:%M"'
else
  # -G: color output
  # -h: human readable size formats
  # -l: long format, one file per line with more info
  # -A: show almost all items including dotfiles, except for `.` and `..`
  alias ls='ls -Gh'  
  alias l='ls -Gh'
  alias ll='ls -GhlA'
fi

# Restart OS X audio
alias restartaudio='sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod'

# Convert mov to gif
function movtogif () {
  local width=${2:-720}
  local filename="${1%.*}"
  local extension="${1##*.}"

  palette_file="${filename}-palette.png"
  ffmpeg -v quiet -i $1 -vf "scale=-2:${width}" "${filename}-resized.mov"
  ffmpeg -v quiet -stats -y -i "${filename}-resized.mov" -vf fps=10,palettegen $palette_file
  ffmpeg -v quiet -stats -i "${filename}-resized.mov" -i $palette_file -filter_complex "fps=10,paletteuse" "${filename}.gif"
  rm $palette_file "${filename}-resized.mov"
}

# Helper function to dump brewfile after certain commands
__dump_brewfile() {
  local main_command="$1"
  local trigger_commands=("${@:2}")  # All arguments except the first one

  for command in "${trigger_commands[@]}"; do
    [[ "${command}" == "${main_command}" ]] && brew bundle dump --file="${HOME}/.brewfile" --force
  done
}

# Automatically dump brewfile for backup
brew() {
  local trigger_commands=('install' 'uninstall' 'tap' 'untap')
  command brew "$@"
  __dump_brewfile "$1" "${trigger_commands[@]}"
}

mas() {
  local trigger_commands=('install' 'uninstall')
  command mas "$@"
  __dump_brewfile "$1" "${trigger_commands[@]}"
}

# Go to project's git root
alias root='cd `git rev-parse --show-toplevel`'

# List open ports
lports() {
  sudo echo 'Processes currently listening on TCP ports'
  sudo lsof -nP -iTCP -sTCP:LISTEN | awk '
  BEGIN {
      printf "%-20s %-10s %-30s\n", "COMMAND", "PID", "ADDRESS";
  }
  NR > 1 {
      key = $1 ":" $2;
      if (key != prev) {
          printf "%-20s %-10s %-30s\n", $1, $2, $9;
          prev = key;
      } else {
          printf "%-20s %-10s %-30s\n", "", "", $9;
      }
  }'
}

# Go to notes and open vim
NOTES_DIR="${HOME}/Projects/pesce.cc/source/"
alias z='cd $NOTES_DIR && nvim'

# Open vim inside cheatsheet directory with Rgi to interactively ripgrep inside it
CHEATSHEET_DIR="${HOME}/Projects/cheatsheet"
alias cheat='vim "+cd $CHEATSHEET_DIR" "+Rgi"'

# Pre-configured tmux sessions
TMUX_SESSIONS="${HOME}/Projects/dotfiles/tmux/sessions/"
alias tmux-vtex='$TMUX_SESSIONS/vtex.sh'
# }}}

# Fuzzy Finder-based functions {{{
# FZF theme
export FZF_DEFAULT_OPTS="
  --color=fg:-1,bg:-1,hl:yellow,fg+:-1,bg+:-1,hl+:yellow
  --color=gutter:black,info:white,border:white,prompt:white,pointer:-1,marker:yellow,spinner:-1,header:-1
"

# Search directories
alias sd='cd $(find * -type d 2>/dev/null | fzf)'

# Search and go to projects
function projects() {
  directory=$(\
    find ~/Projects ~/Projects/oficina ~/Projects/simples ~/Projects/arco ~/Projects/vtex ~/Projects/dotfiles -not -path '*/.*' -maxdepth 1 -type d 2> /dev/null |\
    sort | uniq |\
    fzf-tmux -p 80,85% --prompt='Project ❯ '\
  )
  # Only cd if a directory was selected
  [[ ! -z "$directory" ]] && cd $directory
}
alias prj='projects'

# Bind projects to <CTRL+P>
# functions __projects_widget() { projects && zle accept-line }
# zle -N __projects_widget
# bindkey "^P" __projects_widget

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
