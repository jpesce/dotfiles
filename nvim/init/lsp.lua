vim.cmd [[packadd nvim-lspconfig]]

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

-- Setup servers and execute function when server attaches
local servers = { 'tsserver' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach
  }
end

require'lspconfig'.stylelint_lsp.setup {
  on_attach = on_attach,
  settings = {
    stylelintplus = {
      autoFixOnFormat = true,
    }
  },
}

require'lspconfig'.eslint.setup{
  on_attach = on_attach,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx", "vue", "jsonc", "json" }
}

-- Color number column instead of using sign column
vim.fn.sign_define("DiagnosticSignError", {text = "", numhl = "DiagnosticSignError"})
vim.fn.sign_define("DiagnosticsWarning", {text = "", numhl = "DiagnosticSignWarning"})
vim.fn.sign_define("DiagnosticsInformation", {text = "", numhl = "DiagnosticSignInfo"})
vim.fn.sign_define("DiagnosticsHint", {text = "", numhl = "DiagnosticSignHint"})
