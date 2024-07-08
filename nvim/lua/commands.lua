-- :Date
--  Write the current date before the cursor. In visual mode, replace the selection with the date.
--  Optional argument: string format according to lua's `os.date`. See https://www.lua.org/pil/22.1.html
function Date(table)
  if table.range == 2 then
    -- Get the visual selection range
    vim.cmd 'normal! `<v`>y'
    -- Delete the visual selection
    vim.cmd 'normal! gv"_d'
  end
  if table.args ~= '' then
    vim.api.nvim_put({ os.date(table['args']) }, 'c', false, true)
  else
    vim.api.nvim_put({ os.date() }, 'c', false, true)
  end
end
vim.api.nvim_create_user_command('Date', Date, { nargs = '?', range = true })
