local cmp = require'cmp'

cmp.setup {
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-h>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-l>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    ["<CR>"] = cmp.mapping.confirm { select = true }
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

-- Command line and search autocompletions
local cmdline_mapping = {
  ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
  ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
  ["<CR>"] = cmp.mapping.confirm { select = true }
}

cmp.setup.cmdline(':', {
    mapping = cmdline_mapping,
    sources = {
      { name = 'cmdline' }
    }
  })
cmp.setup.cmdline('/', {
    mapping = cmdline_mapping,
    sources = {
      { name = 'buffer' }
    }
  })
