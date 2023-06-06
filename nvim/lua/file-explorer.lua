-- Local shorteners
local g = vim.g

packer.use "tpope/vim-vinegar"  -- Extend file explorer
g.netrw_banner = 0              -- Don't show info on top
g.netrw_liststyle = 3           -- Use tree style by default
g.netrw_winsize = -30           -- Fixed width for :Lex
