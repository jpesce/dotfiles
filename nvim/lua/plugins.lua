-- PLUGINS
require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-eunuch', -- Add file commands such as :Rename :Move :Delete
  'tpope/vim-abolish', -- Smart substitutions with %S/<find>/<replace>

  { -- Project-specic configurations
    'windwp/nvim-projectconfig',
    config = function()
      require('nvim-projectconfig').setup {
        silent = false,
      }
    end,
  },

  require 'plugins/git',

  { -- Show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Normal mode
      require('which-key').add {
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]iagnostic' },
        { '<leader>g', group = '[G]it' },
        { '<leader>l', group = '[L]ist' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
      }
      -- Visual mode
      require('which-key').add {
        { '<leader>s', group = '[S]earch', mode = 'v' },
        { '<leader>s_', hidden = true, mode = 'v' },
      }
    end,
  },

  require 'plugins/telescope',
  require 'plugins/lsp',

  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd' },
        html = { 'prettierd' },
      },
    },
    config = function(_, opts)
      require('conform').setup(opts)

      -- Format code
      vim.keymap.set('n', '<leader>cf', function()
        require('conform').format()
      end, { desc = '[C]ode [F]ormat' })
    end,
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Accept ([y]es) the completion.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally this isn't needed because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Comment with gc
      require('mini.comment').setup()

      -- Move visual selection with <M-hjkl>
      require('mini.move').setup {
        mappings = {
          -- Disable for normal mode
          line_left = '',
          line_right = '',
          line_down = '',
          line_up = '',
        },
      }

      -- Autopairs
      require('mini.pairs').setup()

      -- Better around/inside textobjects
      --
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Go forward/backward with square brackets
      --
      -- - [B [b ]b ]B - Buffer
      -- - [D [d ]d ]D - Diagnostic
      require('mini.bracketed').setup()

      -- Show buffers in tabline
      require('mini.tabline').setup()
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'c', 'html', 'lua', 'markdown', 'vim', 'vimdoc' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
  {
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
  },
}, {
  ui = {},
})
