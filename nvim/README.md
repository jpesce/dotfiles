<p align="center">
  <h1 align="center">Neovim</h1>
</p>

Configuration for [Neovim](https://neovim.io/).

## Installation

```sh
brew install neovim
```

## Structure

`init.lua` is the entry point. Configuration is split into modules in `lua/`:

| Module | Description |
|--------|-------------|
| `options.lua` | Neovim options |
| `keymaps.lua` | Custom key mappings |
| `commands.lua` | Custom user commands |
| `autocommands.lua` | Autocommands |
| `statusline.lua` | Custom status line |
| `statuscolumn.lua` | Custom status column |
| `plugins.lua` | Plugin definitions (lazy.nvim) |

## Plugins

Managed by [lazy.nvim](https://github.com/folke/lazy.nvim). Key plugins:

| Plugin | Description |
|--------|-------------|
| `telescope.nvim` | Fuzzy finder for files, grep, buffers, LSP symbols |
| `nvim-lspconfig` + `mason.nvim` | LSP support with auto-install |
| `nvim-cmp` | Autocompletion (LSP, snippets, paths) |
| `nvim-treesitter` | Syntax highlighting and code analysis |
| `conform.nvim` | Autoformatting (stylua, prettierd) |
| `vim-fugitive` + `gitsigns.nvim` | Git integration |
| `mini.nvim` | Comment, move, pairs, surround, ai textobjects, bracketed, tabline |
| `which-key.nvim` | Shows pending keybinds |
| `vim-tmux-navigator` | Seamless pane navigation between tmux and Neovim |
| `vim-sleuth` | Auto-detect indentation |
| `vim-eunuch` | File commands (`:Rename`, `:Move`, `:Delete`) |
| `vim-abolish` | Smart substitutions with `%S` |

## Key mappings

Leader key: <kbd>Space</kbd>

| Prefix | Group |
|--------|-------|
| `<leader>c` | Code (format, rename) |
| `<leader>d` | Diagnostic (errors, quickfix, actions) |
| `<leader>g` | Git (diff, blame) |
| `<leader>l` | List (files, buffers, symbols, keymaps) |
| `<leader>s` | Search (grep in buffer/workspace) |
| `<leader>w` | Workspace |

Pane navigation: <kbd>Option</kbd>+<kbd>H</kbd><kbd>J</kbd><kbd>K</kbd><kbd>L</kbd> (shared with tmux)

## Color scheme

`essential` — a custom color scheme in `colors/essential.vim`.
