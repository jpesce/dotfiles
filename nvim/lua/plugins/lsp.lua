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
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          -- Function to mode, buffer and description
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc .. ' (LSP)' })
          end

          -- Go to the definition of the word under your cursor
          --  To jump back in the taglist, press <C-T>
          map('gd', require('telescope.builtin').lsp_definitions, '[G]o to [D]efinition')

          -- Go to declaration, WARN: This is not Go to Definition (see gd)
          --  For example, in C this would take you to the header
          map('gD', vim.lsp.buf.declaration, '[G]o to [D]eclaration')

          -- Go to references for the word under your cursor
          map('gr', require('telescope.builtin').lsp_references, '[G]o to [R]eferences')

          -- Go to the implementation of the word under your cursor
          --  Useful when your language has ways of declaring types without an actual implementation
          map('gI', require('telescope.builtin').lsp_implementations, '[G]o to [I]mplementation')

          -- Go to the type of the word under your cursor
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('gy', require('telescope.builtin').lsp_type_definitions, '[G]o to t[Y]pe definition')

          -- List all the symbols in your current document
          --  Symbols are things like variables, functions, types, etc
          map('<leader>ls', require('telescope.builtin').lsp_document_symbols, '[L]ist buffer [S]ymbols')

          -- List all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project
          map('<leader>lS', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[L]ist workspace [S]ymbols')

          -- Replace the variable under your cursor
          --  Most Language Servers support renaming across files, etc
          map('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]eplace')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate
          map('<leader>da', vim.lsp.buf.code_action, '[D]iagnostic [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map('K', vim.lsp.buf.hover, 'Loo[K]up Documentation')

          -- Define signs
          local signs = {
            { name = 'DiagnosticSignError', text = '🞄' },
            { name = 'DiagnosticSignWarn', text = '🞄' },
            { name = 'DiagnosticSignHint', text = '🞄' },
            { name = 'DiagnosticSignInfo', text = '🞄' },
          }

          for _, sign in ipairs(signs) do
            vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- Add completion capability
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      vim.g.markdown_fenced_languages = {
        'ts=typescript',
      }
      local servers = {
        stylelint_lsp = {},
        eslint = {
          filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
            'vue',
            'jsonc',
            'json',
          },
        },
        gopls = {},
        tailwindcss = {},
        cssls = {},
        -- solargraph = {},
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files loaded in neovim configuration.
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Format lua code
        'prettierd',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration in `servers` table above. Useful for disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      -- Start some LSPs manually because couldn't find a way to start via mason-lspconfig using root_pattern
      local nvim_lspconfig = require 'lspconfig'
      local tsserver_capabilities = {
        documentFormattingProvider = false,
        documentRangeFormattingProvider = false,
      }
      tsserver_capabilities = vim.tbl_deep_extend('force', {}, capabilities, tsserver_capabilities or {})
      -- nvim_lspconfig.tsserver.setup {
      --   root_dir = nvim_lspconfig.util.root_pattern 'package.json',
      --   capabilities = tsserver_capabilities,
      --   single_file_support = false,
      -- }
      nvim_lspconfig.denols.setup {
        root_dir = nvim_lspconfig.util.root_pattern('deno.json', 'deno.jsonc'),
        capabilities = capabilities,
      }
    end,
  },
}
