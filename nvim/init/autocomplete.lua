vim.cmd [[packadd nvim-cmp]]
vim.cmd [[packadd cmp-nvim-lsp]]
vim.cmd [[packadd cmp-buffer]]
vim.cmd [[packadd cmp-path]]
vim.cmd [[packadd cmp-cmdline]]

local cmp = require'cmp'

cmp.setup {
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Left>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<Right>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ['<CR>'] = cmp.mapping.confirm { select = false }
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
  },
  experimental = {
    ghost_text = true,
  },
}

-- Commands
cmp.setup.cmdline(':', {
    completion = {
      autocomplete = false,
    },
    mapping = {
    -- Tab opens completion.
    -- If completion menu is already open, cycle between options
    ['<Tab>'] = cmp.mapping(function()
      if cmp.visible() then cmp.select_next_item() else cmp.complete() end
    end, { 'i', 'c' }),
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<CR>'] = cmp.mapping.confirm { select = true }
  },
  sources = { { name = 'cmdline' } }
})

-- Search
cmp.setup.cmdline('/', {
    mapping = {
      ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ['<CR>'] = cmp.mapping.confirm { select = true }
    },
    sources = { { name = 'buffer' } }
  })
