return {
  'saghen/blink.cmp',
  version = '1.*',
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      list = { selection = { preselect = false, auto_insert = false } },
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      ghost_text = { enabled = true },
      menu = {
        draw = {
          treesitter = { 'lsp' },
          gap = 2,
          columns = {
            { 'kind_icon', 'label', 'label_description', gap = 1 },
            { 'kind' },
          },
        },
      },
    },
    keymap = {
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Esc>'] = { 'cancel', 'fallback' },
    },
    cmdline = {
      keymap = {
        ['<CR>'] = { 'accept', 'fallback' },
        ['<Esc>'] = { 'cancel', 'fallback' },
        ['<Up>'] = { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
      },
      completion = {
        list = { selection = { preselect = false, auto_insert = false } },
        menu = { auto_show = true },
      },
    },
    signature = { enabled = true },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
  },
}
