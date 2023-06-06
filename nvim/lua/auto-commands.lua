local g = vim.g
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remove trailing lines and white spaces on exit
g.remove_white_spaces_blacklist = { "markdown" }
augroup("RemoveWhiteSpacesOnExit", { clear = true })
autocmd("BufWritePre", {
  group = "RemoveWhiteSpacesOnExit",
  command = [[if index(g:remove_white_spaces_blacklist, &ft) < 0 | %s/\s\+$//e | endif]]
})
