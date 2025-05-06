# Visual
# Use color names on zsh commands instead of codes
autoload colors && colors

# Set a custom accent color on color code 16
source "${ZDOTDIR}/scripts/set_custom_colors.sh"
# Set theme
source "${ZDOTDIR}/themes/essential/essential.zsh-theme"

# Highlight commands
source "${ZDOTDIR}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
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