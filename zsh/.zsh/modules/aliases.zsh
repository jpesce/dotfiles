# Aliases

alias c='clear'
# grep colourfuly 🌈
alias grep='grep  --color=auto'
# Restart OS X audio
alias restartaudio='sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod'
# Open nvim with clean state
alias cvim='nvim --clean'

# Directory navigation {{{
# Change directory by simply typing the directory name withou cd
setopt AUTO_CD

# Aliases
alias ..='cd ..'
alias cd..='cd ..'

# Go to project's git root
alias root='cd `git rev-parse --show-toplevel`'
# }}}

# Directory content listing {{{
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
  # -G: color output 🌈
  # -h: human readable size formats
  # -l: long format, one file per line with more info
  # -A: show almost all items including dotfiles, except for `.` and `..`
  alias ls='ls -Gh'  
  alias l='ls -Gh'
  alias ll='ls -GhlA'
fi
# }}}

# *arr services {{{
# Start all *arr services
alias arr-start='open /Applications/Prowlarr.app && open /Applications/Radarr.app && (bazarr > /tmp/bazarr.log 2>&1 &) 2>/dev/null'

# Stop all *arr services
arr-stop() {
  local services=(
    "Prowlarr"
    "Radarr"
    "Python.*bazarr"
  )
  local graceful_shutdown_msg="⌛ Waiting for services to terminate gracefully..."
  
  # Send SIGINT to all services
  for service in "${services[@]}"; do
    pkill -INT -f "$service"
  done
  
  echo -n "$graceful_shutdown_msg"
  
  for i in {5..1}; do
    # Check if any service is still running
    local running=0
    for service in "${services[@]}"; do
      if pgrep -f "$service" > /dev/null; then
        running=1
        break
      fi
    done
    
    if [ $running -eq 0 ]; then
      echo -e "\n✅ All services terminated gracefully."
      return 0
    fi
    
    echo -n "\r\033[K${graceful_shutdown_msg} ${i}s remaining"
    sleep 1
  done
  
  echo -n "\r\033[K${graceful_shutdown_msg} Timeout reached."
  echo -e "\n😡 Force killing remaining services..."
  
  # Force kill remaining services
  for service in "${services[@]}"; do
    pkill -KILL -f "$service"
  done
  
  echo -e "✅ All services terminated."
}

# Send a process to foreground by name
# Example: fgp "bazarr"
fgp() { 
  fg %$(pgrep -f "$1") 
}
# }}}

# Homebrew {{{
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
# }}}

# tmux {{{
# Pre-configured tmux sessions
TMUX_SESSIONS_DIR="${PROJECTS_DIR}/dotfiles/tmux/sessions/"

alias tmux-vtex="${TMUX_SESSIONS_DIR}/vtex.sh" 
# ...
# }}}

# Functions {{{
# List open ports (better looking `lsof -nP -iTCP -sTCP:LISTEN`)
ports() {
  echo '👂 List of processes currently listening on TCP ports\n'
  lsof -nP -iTCP -sTCP:LISTEN | awk '
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
# }}}

# vim: fdm=marker
