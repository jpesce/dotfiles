return {
  { -- Git integration
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit!<CR>', { desc = '[G]it [D]iff' }) -- Get diff in a three-way vertical split
      vim.keymap.set('n', '<leader>gdh', ':diffget //2<CR>', { desc = '[G]it [D]iff from left [H]' }) -- Get change from left (h) pane
      vim.keymap.set('n', '<leader>gdl', ':diffget //3<CR>', { desc = '[G]it [D]iff from right [L]' }) -- Get change from right (l) pane
    end,
  },

  { -- Git - signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '┃' },
        topdelete = { text = '‾' },
        changedelete = { text = '┃' },
      },
      signcolumn = true,
      sign_priority = 99,
      current_line_blame_opts = {
        delay = 100,
      },
    },
    config = function(_, opts)
      require('gitsigns').setup(opts)
      vim.keymap.set('n', '<leader>gb', '<Cmd>Gitsigns toggle_current_line_blame<CR>', { desc = '[G]it [B]lame current line' })
      vim.keymap.set('n', '<leader>gs', '<Cmd>Gitsigns toggle_signs<CR>', { desc = '[G]it [S]igns toggle' })
    end,
  },
}
