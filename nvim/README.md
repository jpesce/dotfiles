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
| `plugins/` | Individual plugin configurations |

## Plugins

Managed by [lazy.nvim](https://github.com/folke/lazy.nvim).

| Feature | Plugins |
|---------|---------|
| Fuzzy finder | `telescope.nvim` |
| LSP | `nvim-lspconfig`, `mason.nvim` |
| Completion | `blink.cmp` |
| Syntax highlighting | `nvim-treesitter` |
| Formatting | `conform.nvim` (stylua, prettierd) |
| File explorer | `neo-tree.nvim` |
| Git | `vim-fugitive`, `gitsigns.nvim` |
| Text objects & UI | `mini.nvim` (move, pairs, surround, ai, bracketed, tabline) |
| Indent guides & scope | `snacks.nvim` (indent guides, scope textobjects `ii`/`ai`, scope jumping `[i`/`]i`) |
| Keybind discovery | `which-key.nvim` |
| Tmux integration | `vim-tmux-navigator` |
| Indentation | `vim-sleuth` |
| File commands | `vim-eunuch` (`:Rename`, `:Move`, `:Delete`) |
| Smart substitution | `vim-abolish` (`%S`) |

## Key mappings

Leader key: <kbd>Space</kbd>

| Prefix | Group |
|--------|-------|
| `<leader>c` | Code (format, rename) |
| `<leader>d` | Diagnostic (errors, quickfix, actions) |
| `<leader>e` | Explorer (toggle file tree) |
| `<leader>g` | Git (diff, blame, signs toggle) |
| `<leader>l` | List (files, buffers, symbols, keymaps) |
| `<leader>s` | Search (grep in buffer/workspace) |

Pane navigation: <kbd>Option</kbd>+<kbd>H</kbd><kbd>J</kbd><kbd>K</kbd><kbd>L</kbd> (shared with tmux)
Buffer navigation: <kbd>Option</kbd>+<kbd>Shift</kbd>+<kbd>[</kbd> / <kbd>]</kbd>

## Color scheme

`essential` — a custom color scheme in `colors/essential.vim`.
