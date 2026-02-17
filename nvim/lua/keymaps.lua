-- KEYMAPS
-- ABOVE-BELOW {{{
-- Add empty lines before and after cursor line
vim.keymap.set('n', '[ ', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = 'Add line above' })
vim.keymap.set('n', '] ', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>", { desc = 'Add line below' })
vim.keymap.set('n', '[p', '<Cmd>put!<CR>', { desc = 'Paste above' })
vim.keymap.set('n', ']p', '<Cmd>put<CR>', { desc = 'Paste below' })
-- }}}

-- RERENDER {{{
vim.keymap.set('n', '<C-l>', ':nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>', { desc = 'C[l]ear search and rerender syntax' })
-- }}}

-- BUFFER NAVIGATION {{{
vim.keymap.set('n', '<M-S-[>', '<Cmd>bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<M-S-]>', '<Cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<M-S-{>', '<Cmd>bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<M-S-}>', '<Cmd>bnext<CR>', { desc = 'Next buffer' })
--  Leave only current [b]uffer open
vim.keymap.set('n', '<Leader>B', ':%bd<bar>e#<bar>bd#<CR>', { desc = 'Leave only current [B]uffer open' })
-- }}}

-- CLIPBOARD-FREE DELETION {{{
vim.keymap.set('x', '<Leader>p', [["_dP]], { desc = '[P]aste without changing the clipboard' })
vim.keymap.set({ 'n', 'v' }, '<Leader>d', [["_d]], { desc = '[D]elete without changing the clipboard' })
vim.keymap.set({ 'n', 'v' }, '<Leader>x', [["_x]], { desc = '[X] Delete without changing the clipboard' })
-- }}}

-- DIAGNOSTICS {{{
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show [D]iagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostic [Q]uickfix list' })
-- }}}

-- VISUAL REPLACE {{{
--  Start command to replace current visual selection

vim.cmd [[ " Escape special characters in a string
function! EscapeString (string)
  let l:string=a:string
  " Escape regex characters
  let l:string = escape(l:string, '^$.*\/~[]#\" ')
  " Escape line endings
  let l:string = substitute(l:string, '\n', '\\n', 'g')
  return l:string
endfunction
]]

vim.cmd [[ " Return text selected in visual mode
function! GetVisualSelection() range
  " Save current register content
  let l:current_register_content = @"
  " Copy selection to the register
  normal! gv""y
  " Save selection to variable
  let l:selection = @"
  " Restore register to old content
  let @" = l:current_register_content

  return l:selection
endfunction
]]

vim.keymap.set('v', '<Leader>r', '<Esc>:%S/<C-r>=EscapeString(GetVisualSelection())<CR>//g<left><left>', { desc = '[R]eplace selection' })
-- }}}

-- INSPECT HIGHLIGHT {{{
vim.keymap.set('n', '<leader>h', ':Inspect<CR>', { desc = 'Inspect [H]ighlight group under cursor' })
-- }}}

-- vim: foldmethod=marker
