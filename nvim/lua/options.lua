-- OPTIONS
-- SENSIBLE DEFAULTS {{{
vim.opt.splitright = true -- Vertical split to the right
vim.opt.splitbelow = true -- Horizontal split to the bottom
vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim
vim.opt.mouse = 'a' -- Enable mouse. Useful for resizing splits for example
vim.opt.scrolloff = 10 -- Show at least 10 lines above and below the cursor
vim.opt.timeoutlen = 500 -- Time to wait for a sequence of keystrokes to complete
-- }}}

-- LINEBRAKING AND INDENTATION {{{
vim.opt.textwidth = 100 -- Responsible line breaking at column 100
vim.opt.breakindent = true -- Wrapped lines will keep indentation
vim.opt.smartindent = true -- Try to indent next lines smartly
vim.opt.expandtab = true -- Convert tab into spaces
vim.opt.tabstop = 2 -- Use 2 spaces for tabs…
vim.opt.softtabstop = 2 -- …spaces…
vim.opt.shiftwidth = 2 -- …and shift indentation command (< and >)
vim.opt.shiftround = true -- Round indent to a multiple of shiftwidth

-- In visual mode, when indenting with < >, keep the selection
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
-- }}}

-- SEARCH {{{
vim.opt.ignorecase = true -- Case-insensitive searching…
vim.opt.smartcase = true -- …unless \C or capital letter in search
vim.opt.inccommand = 'split' -- Preview substitutions live
-- }}}

-- INTERFACE {{{
vim.opt.relativenumber = true -- Show line numbers relative to current line…
vim.opt.number = true -- … except for the current line
vim.opt.showmode = false -- Don't show mode since it's already in status line
vim.opt.signcolumn = 'yes' -- Keep signcolumn on by default
vim.opt.list = true -- Display whitespace visually
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.shortmess = 'I'
-- }}}

-- SAFETY NETS {{{
vim.opt.updatetime = 250 -- Time between swap saves
vim.opt.undofile = true -- Save undo history

-- Add undo breaks to common characters so it doesn't undo more than it should at once
vim.keymap.set('i', '.', '.<C-g>u')
vim.keymap.set('i', ',', ',<C-g>u')
vim.keymap.set('i', '?', '?<C-g>u')
vim.keymap.set('i', '!', '!<C-g>u')
vim.keymap.set('i', '<Space>', '<Space><C-g>u')
vim.keymap.set('i', '<CR>', '<CR><C-g>u')
-- }}}

-- OLD SCHOOL PROJECT NAVIGATION {{{
vim.opt.path:append '**' -- Add project's directories to path to make it easy to :find and [g]o to [f]iles

-- Use Ripgrep in :grep
if vim.fn.executable 'rg' == 1 then
  vim.opt.grepprg = 'rg --vimgrep --no-heading --fixed-strings --'
  vim.opt.grepformat:append '%f:%l:%c:%m'
end

-- Redraw and open quick fix list after grep
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
  desc = 'Redraw and open quick fix list after grep',
  group = vim.api.nvim_create_augroup('redraw_and_open_quickfix_after_grep', { clear = true }),
  pattern = '*grep*',
  callback = function()
    vim.cmd 'redraw!'
    vim.cmd 'copen'
  end,
})

-- Grep silently
vim.cmd 'cnoreabbrev <expr> grep  (getcmdtype() ==# ":" && getcmdline() =~# "^grep")  ? "silent grep!"  : "grep"'
vim.cmd 'cnoreabbrev <expr> lgrep (getcmdtype() ==# ":" && getcmdline() =~# "^lgrep") ? "silent lgrep!" : "lgrep"'

--  :Explorer options
vim.g.netrw_banner = 0 -- Don't show info on top
vim.g.netrw_liststyle = 3 -- Use tree style by default
vim.g.netrw_winsize = -30 -- Fixed width for :Lex
-- }}}

-- FOLDING {{{
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldenable = true
vim.opt.foldtext = '' -- highlight fold lines
vim.opt.fillchars:append 'foldclose:▸'
vim.opt.fillchars:append 'foldopen:▾'
vim.opt.fillchars:append 'foldsep: '
vim.opt.fillchars:append 'fold: '
-- }}}

-- vim: foldmethod=marker
