-- Local shorteners
local g = vim.g
local o = vim.opt

g.mapleader = " "                     -- Leader is <space>

require "plugin-manager"

require "auto-commands"               -- Commands that execute automatically
require "custom-commands"             -- Custom :Commands
require "custom-mappings"             -- Custom keyboard mappings
require "visual"                      -- Visual selection operations

require "file-explorer"
require "tabs"
require "fold"
require "statusline"

packer.use "junegunn/fzf.vim"
vim.cmd("source $HOME/.config/nvim/init/fuzzyfinder.vim")
require "tree-sitter"
require "lsp"
require "autocomplete"

require "tmux-navigator"
require "git"
require "project-config"

-- Fairly sensible options {{{
o.splitright = true                   -- Vertical split to the right
o.splitbelow = true                   -- Horizontal split to the bottom
o.lazyredraw = true                   -- Don't update the display when running macros
o.path = o.path + "**"                -- Project's directories in path to make it easy to :find files
o.clipboard = "unnamedplus"           -- Yank, delete and paste work with the clipboard
o.smartcase = true
o.ignorecase = true
-- }}}

-- Opinionated options {{{
o.mouse = ""                          -- No mouse
o.relativenumber = true               -- Show line numbers relative to current line…
o.number = true                       -- … except for the current line
o.scrolloff = 1000                    -- Cursor always in the middle
o.textwidth = 100                     -- Responsible line breaking at column 100
--- }}}

-- Backup {{{
o.swapfile = false                    -- Don't use swapfiles
o.undofile = true                     -- Undo (u) even if file is closed and reopened

-- Add undo breaks to some characters
vim.keymap.set("i", ".",       ".<C-g>u")
vim.keymap.set("i", ",",       ",<C-g>u")
vim.keymap.set("i", "?",       "?<C-g>u")
vim.keymap.set("i", "!",       "!<C-g>u")
vim.keymap.set("i", "<Space>", "<Space><C-g>u")
vim.keymap.set("i", "<CR>",    "<CR><C-g>u")
--- }}}

-- Indentation {{{
o.shiftround = true                   -- Round indent to a multiple of shiftwidth
o.smartindent = true                  -- Try to indent next lines smartly
o.expandtab = true                    -- Convert tab into spaces
o.tabstop = 2                         -- Use 2 spaces for tabs…
o.softtabstop = 2                     -- … spaces…
o.shiftwidth = 2                      -- … and shift indentation command (< and >)

-- In visual mode, when indenting with < >, keep the selection
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
-- }}}

-- Visuals  {{{
vim.cmd.colorscheme "essential"       -- Color scheme
o.shortmess = o.shortmess + "I"       -- Hide vim intro
o.fillchars = o.fillchars + "vert:│"  -- Vertical split
                          + "eob: "   -- Hide empty lines at the end of buffer
-- }}}

-- Extensions {{{
packer.use "tpope/vim-unimpaired"     -- More previous, next and toggle mappings via [, ] and y
packer.use "tpope/vim-surround"       -- Deal with surrounding characters and HTML tags
packer.use "tpope/vim-commentary"     -- Deal with comments via gc
packer.use "tpope/vim-eunuch"         -- Add file commands such as :Rename :Move :Delete
packer.use "tpope/vim-abolish"        -- Smart substitutions with %S/<find>/<replace>
packer.use "andymass/vim-matchup"     -- % recognize language-specific words
g.matchup_matchparen_offscreen = {}
-- }}}

-- Very specific {{{
vim.cmd("source $HOME/.config/nvim/init/grep.vim")  -- Oldschool :grep with RG
packer.use "gerw/vim-HiLinkTrace"                   -- Show/hide highlight stack with :HLT!
packer.use "lilyinstarlight/vim-sonic-pi"           -- Sonic pi
packer.use "eandrju/cellular-automaton.nvim"        -- Fun animation
vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
-- }}}


-- vim: foldmethod=marker
