return {
  { -- LSP
    --  Use :Mason to check the current status of installed tools and/or manually install
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Show progress in the bottom right corner
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      -- Diagnostics (global, only needs to run once)
      vim.diagnostic.config {
        virtual_text = { current_line = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '•',
            [vim.diagnostic.severity.WARN] = '•',
            [vim.diagnostic.severity.HINT] = '•',
            [vim.diagnostic.severity.INFO] = '•',
          },
        },
      }

      -- Keymaps set on LspAttach (only Picker overrides, built-in defaults handle the rest)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc .. ' (LSP)' })
          end

          -- Override built-in LSP mappings with Picker (fuzzy finder) versions
          map('gd', Picker.lsp_definitions, '[G]o to [D]efinition')
          -- gD goes to the declaration (e.g. header file in C), not the definition/implementation
          map('gD', vim.lsp.buf.declaration, '[G]o to [D]eclaration')
          map('gr', Picker.lsp_references, '[G]o to [R]eferences')
          map('gI', Picker.lsp_implementations, '[G]o to [I]mplementation')
          map('gy', Picker.lsp_type_definitions, '[G]o to t[Y]pe definition')
          map('<leader>ls', Picker.lsp_document_symbols, '[L]ist buffer [s]ymbols')
          map('<leader>lS', Picker.lsp_workspace_symbols, '[L]ist workspace [S]ymbols')

          -- Code actions (under both [C]ode and [D]iagnostic groups)
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('<leader>da', vim.lsp.buf.code_action, '[D]iagnostic [A]ction')

          map('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')

          -- Hide built-in LSP mappings replaced by custom ones
          require('which-key').add {
            { 'gra', hidden = true },
            { 'gri', hidden = true },
            { 'grn', hidden = true },
            { 'grr', hidden = true },
            { 'grt', hidden = true },
          }
        end,
      })

      -- Global capabilities for all LSP servers
      vim.lsp.config('*', {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
      })

      -- Add vim.* completions and LuaJIT runtime when editing Neovim config
      vim.lsp.config('lua_ls', {
        on_init = function(client)
          if client.workspace_folders then
            local root = client.workspace_folders[1].name
            if root ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(root .. '/.luarc.json') or vim.uv.fs_stat(root .. '/.luarc.jsonc')) then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME,
                '${3rd}/luv/library',
              },
            },
            completion = {
              callSnippet = 'Replace',
            },
          })
        end,
      })

      vim.g.markdown_fenced_languages = { 'ts=typescript' }

      -- Mason: install tools + auto-enable LSP servers
      require('mason').setup()
      require('mason-tool-installer').setup {
        ensure_installed = {
          'stylelint_lsp',
          'eslint',
          'tailwindcss',
          'cssls',
          'lua_ls',
          'stylua',
          'prettierd',
        },
      }
      require('mason-lspconfig').setup { automatic_enable = true }

      -- Non-mason servers
      vim.lsp.enable 'denols'
    end,
  },
}
