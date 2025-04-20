-- Hide fill chars
vim.opt.fillchars = vim.opt.fillchars + 'stl: ' + 'stlnc: '

-- Show only one statusline for the whole window
vim.opt.laststatus = 3

local function status_line()
  local mode_highlight = '%#AccentInverted#'
  local mode = ' %{%v:lua.string.upper(v:lua.vim.fn.mode())%} '
  local default_highlight = '%#StatusLine#'
  local filename = '  %f %m  '
  local space = '%='
  local line_and_column = '  = %l:%c  '

  return table.concat {
    mode_highlight,
    mode,
    default_highlight,
    filename,
    space,
    line_and_column,
  }
end

vim.opt.statusline = status_line()
