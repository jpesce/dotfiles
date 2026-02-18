-- PLUGINS
require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'tpope/vim-eunuch', -- Add file commands such as :Rename :Move :Delete
  'tpope/vim-abolish', -- Smart substitutions with %S/<find>/<replace>

  require 'plugins/git',
  require 'plugins/which-key',
  -- require 'plugins/fuzzyfinder/fzf',
  require 'plugins/fuzzyfinder/telescope',
  require 'plugins/lsp',
  require 'plugins/formatter',
  require 'plugins/completion',
  require 'plugins/mini',
  require 'plugins/treesitter',
  require 'plugins/tmux-navigator',
}, {
  ui = {},
})
