local opt = vim.opt

-- -- When completing commands, first complete as much as possible and on the next
-- -- <tab>, cycle through options
-- opt.wildmode =  "longest:full,full"
-- -- Don't insert the first item of the menu automatically
-- opt.completeopt = "menuone,noselect"
-- -- Don't show messages on ruler about number of completions
-- opt.shortmess = opt.shortmess + "c"

packer.use {
  -- Snippets
  'L3MON4D3/LuaSnip',

  -- Autocompletion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'saadparwaiz1/cmp_luasnip',
}

local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup({
  snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<Left>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    ['<Right>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- Commands
cmp.setup.cmdline(':', {
  mapping = {
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<CR>'] = cmp.mapping.confirm { select = true }
  },
  sources = {{
    name = 'cmdline',
    keyword_length = 2
  }}
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
