return {
  { -- File explorer sidebar
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>e', '<Cmd>Neotree toggle<CR>', desc = 'File [E]xplorer' },
    },
    opts = {
      default_component_configs = {
        name = {
          use_git_status_colors = false,
        },
        git_status = {
          symbols = {
            -- index (staged)
            added = '',
            modified = '',
            deleted = '',
            renamed = '',
            staged = '●',
            -- working tree
            unstaged = '○',
            untracked = '○',
            ignored = '○',
            conflict = '',
          },
        },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = true,
        },
      },
    },
  },
}
