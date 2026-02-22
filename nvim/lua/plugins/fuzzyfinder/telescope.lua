return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
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
          color_devicons = false,
          layout_config = { width = 0.95 },
          file_ignore_patterns = TelescopeFileIgnorePatterns or {},
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

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      local builtin = require 'telescope.builtin'

      -- Generic picker interface (used by other modules like lsp.lua)
      _G.Picker = {
        lsp_definitions = builtin.lsp_definitions,
        lsp_references = builtin.lsp_references,
        lsp_implementations = builtin.lsp_implementations,
        lsp_type_definitions = builtin.lsp_type_definitions,
        lsp_document_symbols = builtin.lsp_document_symbols,
        lsp_workspace_symbols = builtin.lsp_dynamic_workspace_symbols,
      }

      -- Get current visual selection to use in picker commands
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

      -- LIST
      vim.keymap.set('n', '<leader>lz', builtin.builtin, { desc = '[L]ist Telescope capabilties' })

      vim.keymap.set('n', '<leader>lf', function()
        builtin.find_files { hidden = TelescopeShowHidden or false }
      end, { desc = '[L]ist [F]iles in workspace' })
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
          -- winblend = 10, -- only works with termguicolors
          previewer = false,
        })
      end, { desc = '[S]earch in [B]uffer' })
      vim.keymap.set('n', '<leader>so', function()
        local opts = {
          grep_open_files = true,
          prompt_title = 'Live grep in open buffers',
        }
        if TelescopeShowHidden then
          opts.additional_args = { '--hidden' }
        end
        builtin.live_grep(opts)
      end, { desc = '[S]earch in [O]pen buffers' })
      vim.keymap.set('n', '<leader>sw', function()
        builtin.live_grep(TelescopeShowHidden and { additional_args = { '--hidden' } } or {})
      end, { desc = '[S]earch in [W]orkspace' })

      -- VISUAL GREP
      vim.keymap.set('v', '<space>sb', function()
        local text = getVisualSelection()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          -- winblend = 10, -- only works with termguicolors
          previewer = false,
          default_text = text,
        })
      end, { desc = '[S]earch selection in [B]uffer' })

      vim.keymap.set('v', '<space>sw', function()
        local text = getVisualSelection()
        local opts = { default_text = text }
        if TelescopeShowHidden then
          opts.additional_args = { '--hidden' }
        end
        builtin.live_grep(opts)
      end, { desc = '[S]earch selection in [W]orkspace' })
    end,
  },
}
