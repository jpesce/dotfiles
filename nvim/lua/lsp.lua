local opt = vim.opt

opt.signcolumn = "yes"

packer.use {
  -- LSP
  'neovim/nvim-lspconfig',

  -- LSP installer
  'williamboman/mason.nvim', run = ':MasonUpdate',
  'williamboman/mason-lspconfig.nvim',
}

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "tsserver",
    "eslint",
    "lua_ls"
  },
}

-- Mappings that bind only when the server is attached
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ff', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end


local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Servers
require('lspconfig').tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach
}

require'lspconfig'.lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- Stylelint
require'lspconfig'.stylelint_lsp.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    stylelintplus = {
      autoFixOnFormat = true,
    }
  },
}

-- eslint
require'lspconfig'.eslint.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    "jsonc",
    "json",
  }
}

-- Signs
local signs = {
  { name = "DiagnosticSignError", text = "🞄" },
  { name = "DiagnosticSignWarn",  text = "🞄" },
  { name = "DiagnosticSignHint",  text = "🞄" },
  { name = "DiagnosticSignInfo",  text = "🞄" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end
