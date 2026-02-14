# Zsh

Configuration for [Zsh](https://zsh.sourceforge.io/Doc/).

## Installation

Comes with macOS. The bundled version is kept reasonably up to date and works fine — no need to reinstall via Homebrew.

## Structure

`.zshenv` sets `ZDOTDIR=~/.zsh`, redirecting all Zsh config to the `.zsh/` directory. The configuration is split into modules loaded explicitly from `.zshrc`.

## Modules

| Module | Description |
|--------|-------------|
| `homebrew.zsh` | Auto-dumps Brewfile after install/uninstall commands |
| `vi.zsh` | Vi keybinding mode with cursor shape changes, sets `nvim` as default editor |
| `completion.zsh` | Inline suggestions, tab menu, case-insensitive matching |
| `history.zsh` | Persistent history with deduplication |
| `visual.zsh` | Colors, theme loading, and syntax highlighting styles |
| `asdf.zsh` | Initializes [asdf](https://asdf-vm.com/) version manager |
| `aliases.zsh` | Command shortcuts and directory navigation |
| `fzf.zsh` | Fuzzy finder key bindings, completion, and project navigation |
| `cheatsheet.zsh` | Fuzzy-find and open personal cheatsheet files in Neovim |
| `utils.zsh` | Utilities for compiling zsh scripts and testing startup time |
| `tmux.zsh` | Auto-renames tmux sessions to match the git repo name |

## Plugins

Managed as git submodules in `plugins/`:

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-async](https://github.com/mafredri/zsh-async)
- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)

## Theme

Custom `essential` theme — minimal prompt with return status colors and tmux status bar refresh.
