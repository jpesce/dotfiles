-- KEYMAPS
-- ABOVE-BELOW {{{
-- Add empty lines before and after cursor line
vim.keymap.set('n', '[ ', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = 'Add line above' })
vim.keymap.set('n', '] ', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>", { desc = 'Add line below' })
vim.keymap.set('n', '[p', '<Cmd>put!<CR>', { desc = 'Paste above' })
vim.keymap.set('n', ']p', '<Cmd>put<CR>', { desc = 'Paste below' })
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

-- Escape special characters for use in a substitute pattern
---@diagnostic disable-next-line: duplicate-set-field
function _G.escape_string(str)
  str = vim.fn.escape(str, [[^$.*\/~[]#" ]])
  str = str:gsub('\n', '\\n')
  return str
end

-- Return text selected in visual mode
---@diagnostic disable-next-line: duplicate-set-field
function _G.get_visual_selection()
  local current = vim.fn.getreg '"'
  vim.cmd 'normal! gv""y'
  local selection = vim.fn.getreg '"'
  vim.fn.setreg('"', current)
  return selection
end

vim.keymap.set('v', '<Leader>r', '<Esc>:%s/<C-r>=v:lua.escape_string(v:lua.get_visual_selection())<CR>', { desc = '[R]eplace selection' })
vim.keymap.set(
  'v',
  '<Leader>R',
  '<Esc>:%S/<C-r>=v:lua.escape_string(v:lua.get_visual_selection())<CR>//g<left><left>',
  { desc = '[R]eplace selection preserving case' }
)
-- }}}

-- INSPECT HIGHLIGHT {{{
vim.keymap.set('n', '<leader>h', ':Inspect<CR>', { desc = 'Inspect [H]ighlight group under cursor' })
-- }}}

-- vim: foldmethod=marker
