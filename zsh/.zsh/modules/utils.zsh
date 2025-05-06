# ZSH-useful functions
# Compile ZSH scripts
zsh-compile() {
  for zfile in $ZDOTDIR/**/*.zsh(|-theme)(N-.); do
    zcompile -R ${zfile} && print -PR "%F{green}→%f %B${zfile}:%b Compiled"
  done
  print -P '🦾 Done compiling.'
}

# Clean compiled files
zsh-compile-clean() {
  for zfile in $ZDOTDIR/**/*.zwc; do
    rm -f ${zfile} && print -PR "%F{green}→%f %B${zfile}:%b Removed"
  done
  print -P '🧹 Done cleaning.'
}

# Test zsh startup time
zsh-startup-time() {
  shell=${1-$SHELL}
  for i in $(seq 1 4); do /usr/bin/time $shell -i -c exit; done
} 