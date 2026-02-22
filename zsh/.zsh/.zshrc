# Locales
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8 

# Suggest commands corrections
setopt CORRECT

# Sets PATH, MANPATH, and INFOPATH to include Homebrew's locations
eval "$(/opt/homebrew/bin/brew shellenv)" 

# Directories
export MODULES_DIR=$ZDOTDIR/modules
export PROJECTS_DIR=$HOME/Projects

# Deferred loading
source $ZDOTDIR/plugins/zsh-defer/zsh-defer.plugin.zsh

# Load critical modules immediately
source $MODULES_DIR/vi.zsh
source $MODULES_DIR/history.zsh
source $MODULES_DIR/completion.zsh
source $MODULES_DIR/visual.zsh

# Defer non-critical modules (loaded right after first prompt)
zsh-defer source $MODULES_DIR/homebrew.zsh
zsh-defer source $MODULES_DIR/asdf.zsh
zsh-defer source $MODULES_DIR/aliases.zsh
zsh-defer source $MODULES_DIR/fzf.zsh
zsh-defer source $MODULES_DIR/cheatsheet.zsh
zsh-defer source $MODULES_DIR/utils.zsh
zsh-defer source $MODULES_DIR/tmux.zsh

# vim: fdm=marker
