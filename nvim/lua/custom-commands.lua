-- New logfile at logbook location
local logbook_location = "~/Projects/shite/source/logs/"
vim.api.nvim_create_user_command(
  "NewLog",
  ":execute ':e' '" .. logbook_location .. "' . strftime('%y%m%d%H%M%S') . '.md'",
  { nargs = 0 }
)
