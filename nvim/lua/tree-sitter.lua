packer.use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
packer.use "nvim-treesitter/playground"

vim.keymap.set("n", "<C-e>",
  function()
    local result = vim.treesitter.get_captures_at_cursor(0)
    print(vim.inspect(result))
  end,
  { noremap = true }
)

require"nvim-treesitter.configs".setup {
  sync_install = false, -- Install asynchronously
  auto_install = true,  -- Auto install when entering buffers
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false, -- Don't use :syntax when we have tree-sitter
  },
  indent = { enable = true },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

