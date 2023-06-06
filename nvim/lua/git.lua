packer.use "tpope/vim-fugitive"

vim.keymap.set("n", "<leader>gd", ":Gvdiffsplit!<CR>") -- Get diff in a three-way vertical split
vim.keymap.set("n", "<leader>gdh", ":diffget //2<CR>") -- Get change from left (h) pane
vim.keymap.set("n", "<leader>gdl", ":diffget //3<CR>") -- Get change from right (l) pane

