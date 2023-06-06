-- Leave only current (B)uffer open
vim.keymap.set("n", "<Leader>B", ":%bd<bar>e#<bar>bd#<CR>")

-- Delete and paste without changing the clipboard
vim.keymap.set("x", "<Leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<Leader>d", [["_d]])

-- <C-L> clears search and rerenders syntax
vim.keymap.set("n", "<C-l>", ":nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>")
