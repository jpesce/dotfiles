# Locales
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8 

# Suggest commands corrections
setopt CORRECT

# Sets PATH, MANPATH, and INFOPATH to include Homebrew's locations
eval "$(/opt/homebrew/bin/brew shellenv)" 

# Directories
MODULES_DIR=$ZDOTDIR/modules
PROJECTS_DIR=$HOME/Projects

# Load all modules explicitly in order
source $MODULES_DIR/vi.zsh
source $MODULES_DIR/completion.zsh
source $MODULES_DIR/history.zsh
source $MODULES_DIR/visual.zsh
source $MODULES_DIR/asdf.zsh
source $MODULES_DIR/aliases.zsh
source $MODULES_DIR/fzf.zsh
source $MODULES_DIR/cheatsheet.zsh
source $MODULES_DIR/utils.zsh

# vim: fdm=marker
