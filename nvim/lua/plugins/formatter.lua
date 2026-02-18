return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = false,
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
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
}
