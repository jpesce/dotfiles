return {
  {
    'ibhagwan/fzf-lua',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local fzf = require 'fzf-lua'

      fzf.setup {
        winopts = { width = 0.95 },
        file_ignore_patterns = FzfFileIgnorePatterns or {},
        color_icons = false,
        buffers = {
          previewer = false,
          actions = {
            ['ctrl-x'] = { fn = fzf.actions.buf_del, reload = true },
          },
        },
      }

      fzf.register_ui_select()

      -- Generic picker interface (used by other modules like lsp.lua)
      _G.Picker = {
        lsp_definitions = fzf.lsp_definitions,
        lsp_references = fzf.lsp_references,
        lsp_implementations = fzf.lsp_implementations,
        lsp_type_definitions = fzf.lsp_typedefs,
        lsp_document_symbols = fzf.lsp_document_symbols,
        lsp_workspace_symbols = fzf.lsp_workspace_symbols,
      }

      -- LIST
      vim.keymap.set('n', '<leader>lz', fzf.builtin, { desc = '[L]ist f[z]f-lua capabilties' })

      vim.keymap.set('n', '<leader>lf', fzf.files, { desc = '[L]ist [F]iles in workspace' })
      vim.keymap.set('n', '<leader>lb', fzf.buffers, { desc = '[L]ist [B]uffers' })

      vim.keymap.set('n', '<leader>lh', fzf.help_tags, { desc = '[L]ist [H]elp' })
      vim.keymap.set('n', '<leader>lk', fzf.keymaps, { desc = '[L]ist [K]eymaps' })
      vim.keymap.set('n', '<leader>ld', fzf.diagnostics_workspace, { desc = '[L]ist [D]iagnostics' })

      vim.keymap.set('n', '<leader>lr', fzf.resume, { desc = '[L]ist [R]esume' })

      vim.keymap.set('n', '<leader>ln', function()
        fzf.files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[L]ist [N]eovim files' })

      -- SEARCH (GREP)
      vim.keymap.set('n', '<leader>sb', fzf.blines, { desc = '[S]earch in [B]uffer' })
      vim.keymap.set('n', '<leader>so', fzf.lines, { desc = '[S]earch in [O]pen buffers' })
      vim.keymap.set('n', '<leader>sw', fzf.live_grep, { desc = '[S]earch in [W]orkspace' })

      -- VISUAL GREP
      vim.keymap.set('v', '<space>sb', function()
        fzf.blines { search = fzf.utils.get_visual_selection() }
      end, { desc = '[S]earch selection in [B]uffer' })

      vim.keymap.set('v', '<space>sw', fzf.grep_visual, { desc = '[S]earch selection in [W]orkspace' })
    end,
  },
}
