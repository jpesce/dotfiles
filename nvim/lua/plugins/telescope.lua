return {
  { -- FUZZY FINDER
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = TelescopeFileIgnorePatterns or {},
          color_devicons = false,
          layout_config = { width = 0.95 },
          mappings = {
            i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          },
        },
        pickers = {
          buffers = {
            show_all_buffers = true,
            sort_lastused = true,
            theme = 'dropdown',
            previewer = false,
            mappings = {
              n = {
                ['x'] = 'delete_buffer',
              },
              i = {
                ['<c-x>'] = 'delete_buffer',
              },
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Get current visual selection to use in telescope commands
      local function getVisualSelection()
        vim.cmd 'noau normal! "vy"'
        local text = vim.fn.getreg 'v'
        vim.fn.setreg('v', {})

        text = string.gsub(text, '\n', '')
        if #text > 0 then
          return text
        else
          return ''
        end
      end

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'

      -- LIST
      vim.keymap.set('n', '<leader>lt', builtin.builtin, { desc = '[L]ist [T]elescope capabilties' })

      vim.keymap.set('n', '<leader>lf', builtin.find_files, { desc = '[L]ist [F]iles in workspace' })
      vim.keymap.set('n', '<leader>lb', builtin.buffers, { desc = '[L]ist [B]uffers' })

      vim.keymap.set('n', '<leader>lh', builtin.help_tags, { desc = '[L]ist [H]elp' })
      vim.keymap.set('n', '<leader>lk', builtin.keymaps, { desc = '[L]ist [K]eymaps' })
      vim.keymap.set('n', '<leader>ld', builtin.diagnostics, { desc = '[L]ist [D]iagnostics' })

      vim.keymap.set('n', '<leader>lr', builtin.resume, { desc = '[L]ist [R]esume' })

      vim.keymap.set('n', '<leader>ln', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[L]ist [N]eovim files' })

      -- SEARCH (GREP)
      vim.keymap.set('n', '<leader>sb', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[S]earch in [B]uffer' })
      vim.keymap.set('n', '<leader>so', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live grep in open buffers',
        }
      end, { desc = '[S]earch in [O]pen buffers' })
      vim.keymap.set('n', '<leader>sw', builtin.live_grep, { desc = '[S]earch in [W]workspace' })

      -- VISUAL GREP
      vim.keymap.set('v', '<space>sb', function()
        local text = getVisualSelection()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
          default_text = text,
        })
      end, { desc = '[S]earch selection in [B]uffer' })

      vim.keymap.set('v', '<space>sw', function()
        local text = getVisualSelection()
        builtin.live_grep { default_text = text }
      end, { desc = '[S]earch selection in [W]orkspace' })
    end,
  },
}
