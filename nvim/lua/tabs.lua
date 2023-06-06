-- Show buffers as tabs using tabline
packer.use "ap/vim-buftabline"

vim.g.buftabline_indicators = 1 -- Show modified flag
vim.g.buftabline_show = 1       -- Don't show tabline if there is only one buffer
