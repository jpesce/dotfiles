local ensure_packer_is_installed = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_just_installed = ensure_packer_is_installed()

packer = require 'packer'
local util = require 'packer.util'

packer.init({
	package_root = util.join_paths(vim.fn.stdpath('config'), 'pack')
})

packer.use 'wbthomason/packer.nvim'

if packer_just_installed then
  require('packer').sync()
end
