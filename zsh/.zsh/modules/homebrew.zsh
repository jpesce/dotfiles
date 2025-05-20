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
