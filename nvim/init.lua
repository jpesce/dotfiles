-- Globals
--  Need to be the first thing
vim.g.mapleader = ' ' -- <space> as the leader key
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.opt.termguicolors = false -- Use cterm colors
vim.cmd.colorscheme 'essential'

require 'options' -- Neovim options
require 'keymaps' -- Extra keyboard mappings
require 'commands' -- Custom user commands
require 'autocommands' -- Automatically executed commands
require 'statusline' -- Very simple status line
require 'statuscolumn' -- Custom status column

--  Install lazy plugin manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins
require 'plugins'
