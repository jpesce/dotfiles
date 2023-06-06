-- Navigate tmux panes and vim splits seamlessly
packer.use "christoomey/vim-tmux-navigator"

-- Use <Option-hjkl> instead of default keybindings
vim.g.tmux_navigator_no_mappings = 1

vim.keymap.set("n", "<A-h>", ":TmuxNavigateLeft<CR>",  { silent = true })
vim.keymap.set("n", "<A-j>", ":TmuxNavigateDown<CR>",  { silent = true })
vim.keymap.set("n", "<A-k>", ":TmuxNavigateUp<CR>",    { silent = true })
vim.keymap.set("n", "<A-l>", ":TmuxNavigateRight<CR>", { silent = true })

