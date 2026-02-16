# Cheatsheet
# Requires fzf, ripgrep, and Neovim

# Open Neovim inside cheatsheet directory with Rgi to interactively ripgrep inside it
CHEATSHEET_DIR="${PROJECTS_DIR}/cheatsheet"
alias cheatsheet-edit='nvim "+cd $CHEATSHEET_DIR" "+Rgi"'
alias ch-edit='nvim "+cd $CHEATSHEET_DIR" "+Rgi"'

# Interactively search cheatsheet directory and open the selected file in Neovim
# Usage: ch <query>
# Example: 
#  - ch
#  - ch "git"
alias ch='cheatsheet'
cheatsheet() {
  RG_PREFIX="rg --column --line-number --no-heading --smart-case "
  RG_PREFIX+="--color=always --colors 'column:fg:white' --colors 'line:fg:white' --colors 'path:fg:green' --colors 'match:fg:black' --colors 'match:bg:15'"

  # Change to cheatsheet directory so rg output doesn't include the full path,
  # making it nicer to the eyes in fzf
  cd "$CHEATSHEET_DIR"

  # Start fzf searching for the argument given to cheatsheet ($1)
  location=$(\
    eval "${RG_PREFIX} '$1'" |
    fzf-tmux -p 90%,90% --prompt='Cheatsheet ❯ '\
    --bind "change:reload:$RG_PREFIX {q} || true" --ansi --phony --preview "$ZDOTDIR/scripts/cheatsheet/preview.sh {}" \
  )

  # Only continue if an option was selected
  if [[ ! -z "$location" ]]
  then
    local parts=("${(@s/:/)location}")
    local filename="${parts[1]}"
    local line="${parts[2]}"
    local column="${parts[3]}"
    nvim "+call cursor($line,$column)" "$filename"
  fi

  # Change back to previous directory
  # Don't output the path to terminal
  cd - > /dev/null 
} 