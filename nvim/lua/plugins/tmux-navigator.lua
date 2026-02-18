return {
  'christoomey/vim-tmux-navigator',
  init = function()
    -- Don't use default mappings
    vim.g.tmux_navigator_no_mappings = 1
  end,
  config = function()
    -- Use <Option-hjkl> instead of default keybindings
    vim.keymap.set('n', '<A-h>', ':TmuxNavigateLeft<CR>', { silent = true })
    vim.keymap.set('n', '<A-j>', ':TmuxNavigateDown<CR>', { silent = true })
    vim.keymap.set('n', '<A-k>', ':TmuxNavigateUp<CR>', { silent = true })
    vim.keymap.set('n', '<A-l>', ':TmuxNavigateRight<CR>', { silent = true })
  end,
}
