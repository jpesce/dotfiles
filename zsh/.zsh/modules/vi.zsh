# vi integration
# Use vi mode on prompt
bindkey -v

# Increase vi-like zsh functionality
# See: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/vi-mode
# Change cursor for normal and insert mode
VI_MODE_SET_CURSOR=true
source $ZDOTDIR/plugins/ohmyzsh/plugins/vi-mode/vi-mode.plugin.zsh
# V to edit command in vi
bindkey -M vicmd 'V' edit-command-line

# Set nvim as the default editor
export EDITOR=nvim 