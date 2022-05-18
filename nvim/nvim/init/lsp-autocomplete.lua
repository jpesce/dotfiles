local cmp = require'cmp'

cmp.setup {
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-h>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-l>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<CR>"] = cmp.mapping.confirm { select = false }
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
  experimental = {
    ghost_text = true,
  },
}

-- Command/search autocompletions
cmp.setup.cmdline(':', {
    completion = {
      autocomplete = false,
    },
    mapping = {
      ["<Tab>"] = cmp.mapping(cmp.mapping.complete({ reason = cmp.ContextReason.Auto, }), {"i", "c"}),
      ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ["<CR>"] = cmp.mapping.confirm { select = true }
    },
    sources = { { name = 'cmdline' } }
  })

cmp.setup.cmdline('/', {
    mapping = {
      ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
      ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
      ["<CR>"] = cmp.mapping.confirm { select = true }
    },
    sources = { { name = 'buffer' } }
  })
