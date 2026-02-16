# ASDF: General purpose version manager for tools and runtimes such as Node.js, Ruby, Python, etc.
if command -v brew &>/dev/null && [[ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]]; then
  . "$(brew --prefix asdf)/libexec/asdf.sh"
else
  echo "\033[33m!\033[0m \033[1masdf\033[0m not found. Install with \033[1mbrew install asdf\033[0m"
fi