# Fuzzy Finder
# Set up fzf key bindings and fuzzy completion
if command -v fzf &>/dev/null; then
  source <(fzf --zsh)
else
  echo "\033[33m!\033[0m \033[1mfzf\033[0m not found. Install with \033[1mbrew install fzf\033[0m"
  return
fi

# fzf theme
export FZF_DEFAULT_OPTS="
  --color=fg:-1,bg:-1,hl:yellow,fg+:-1,bg+:-1,hl+:yellow
  --color=gutter:black,info:white,border:white,prompt:white,pointer:-1,marker:yellow,spinner:-1,header:-1
"

# Search and go to projects
alias prj='projects'
function projects() {
  # Project directories to search
  PROJECT_DIRECTORIES=(
    "${PROJECTS_DIR}"
    "${PROJECTS_DIR}/oficina"
    "${PROJECTS_DIR}/simples"
    "${PROJECTS_DIR}/arco"
    "${PROJECTS_DIR}/vtex"
    "${PROJECTS_DIR}/dotfiles"
  )

  directory=$(\
    find ${PROJECT_DIRECTORIES[@]} -not -path '*/.*' -maxdepth 1 -type d 2> /dev/null |\
    sort | uniq |\
    fzf-tmux -p 80,85% --prompt='Project ❯ '\
  )

  # Only cd if the selected option is a directory
  [[ ! -z "$directory" ]] && cd "$directory"
} 