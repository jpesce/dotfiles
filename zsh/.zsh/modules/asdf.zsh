# ASDF: General purpose version manager for tools and runtimes such as Node.js, Ruby, Python, etc.
# asdf 0.16+ is a Go binary and no longer ships asdf.sh — put its shims on PATH instead.
if command -v asdf >/dev/null 2>&1; then
  export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
else
  echo "\033[33m!\033[0m \033[1masdf\033[0m not found. Install with \033[1mbrew install asdf\033[0m"
fi
