#!/bin/bash

# ---- Custom terminal colors
# Custom colors for gray ramp
# Taken from base-16. See https://github.com/chriskempson/base16-shell/blob/efa06ce77a7fa46cca2bfc07932db21971de010b/templates/default.mustache
put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
put_template 232 29/27/29
put_template 233 31/2F/31
put_template 234 39/37/38
put_template 235 42/3F/40
put_template 236 4A/47/48
put_template 237 52/4F/4F
put_template 238 5A/58/57
put_template 239 63/60/5E
put_template 240 6B/68/66
put_template 241 73/70/6E
put_template 242 7B/78/75
put_template 243 84/80/7D
put_template 244 8C/89/85
put_template 245 94/91/8C
put_template 246 9D/99/94
put_template 247 A5/A1/9B
put_template 248 AD/A9/A3
put_template 249 B5/B1/AB
put_template 250 BE/B9/B2
put_template 251 C6/C2/BA
put_template 252 CE/CA/C1
put_template 253 D6/D2/C9
put_template 254 DF/DA/D1
put_template 255 E7/E2/D8
put_template 256 EF/EA/E0

# ---- Prompt Style
gray="\[\033[38;5;240m\]"
reset="\[$(tput sgr0)\]"

PS1="\n"

# Add host if SSHing
if [ "$SSH_CONNECTION" ]; then
  PS1+="$reset$gray"' \u@\h ❯'
fi

# Add git-prompt if installed
if [ -f "$(brew --prefix)/etc/bash_completion.d/git-prompt.sh" ]
then
  . "$(brew --prefix)/etc/bash_completion.d/git-prompt.sh"
  GIT_PS1_SHOWDIRTYSTATE=true
  # Prevent __git_ps1 not found error on sudo
  PS1+="$reset$gray"'$(if [ $(id -u) -ne 0 ]; then printf "%s" "$(__git_ps1 "   %s ❯")" ; fi)'
fi

PS1+="$reset$gray \w ❯"
PS1+="$reset  "
export PS1

# ---- Options
# Vim as default editor
export EDITOR=vim
# Vi mode
set -o vi

# ---- Locales
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ---- Paths
# PostgreSQL
PATH=$PATH:/Library/PostgreSQL/12/bin
# Rails in dev mode when running local
export RAILS_ENV=development
# Open SSL
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
# Libffi
export LDFLAGS="-L/usr/local/opt/libffi/lib"
export CPPFLAGS="-I/usr/local/opt/libffi/include"

# ---- Alias
alias ..='cd ..'
alias cd..='cd ..'
alias c='clear'
alias restartaudio='sudo launchctl stop com.apple.audio.coreaudiod && sudo launchctl start com.apple.audio.coreaudiod'

# ---- LS
# LS Color code (see: https://gist.github.com/thomd/7667642)
LS_COLORS='di=1;34:fi=0:ln=3:pi=0:so=0:bd=0:cd=0:or=0:mi=31:ex=0'
export LS_COLORS
# Use coreutils ls (gls)
alias ls='gls --color --human-readable --group-directories-first'
alias l='ls'


# ---- Completion
# Bash completion
[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
# Git completion
[[ -r "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ]] && . "$(brew --prefix)/etc/bash_completion.d/git-completion.bash"

# ---- rbenv
# Load rbenv everytime terminal starts
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# ---- nvm
# Add nvm path
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
