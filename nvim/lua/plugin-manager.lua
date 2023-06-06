packer = require 'packer'
local util = require 'packer.util'

packer.init({
	package_root = util.join_paths(vim.fn.stdpath('config'), 'pack')
})

packer.use 'wbthomason/packer.nvim'
