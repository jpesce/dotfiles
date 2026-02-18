-- Align string
local pad_string = function(string, width, align)
  local right_align_token = '%='

  local num_spaces = width - #string
  if num_spaces < 1 then
    num_spaces = 1
  end
  local spaces = string.rep(' ', num_spaces)

  if align == 'left' then
    return table.concat { string, spaces }
  end

  return table.concat { spaces, string, right_align_token }
end

-- Make highlight string
local function make_highlight_string(highlight_name)
  return table.concat { '%#', highlight_name, '#' }
end

-- Highlight text and reset highlight
local function highlight_text(highlight, text)
  return table.concat { make_highlight_string(highlight), text, '%*' }
end

local fillchars = vim.opt.fillchars:get()

local function get_fold(line_number)
  if vim.fn.foldlevel(line_number) <= vim.fn.foldlevel(line_number - 1) then
    return ' '
  end
  return vim.fn.foldclosed(line_number) == -1 and fillchars.foldopen or fillchars.foldclose
end

local function line_number_width()
  return math.max(3, #tostring(vim.api.nvim_buf_line_count(0)))
end

local function get_line_number()
  -- Get absolute line number if is current line or else get relative num
  local cur_num = vim.v.relnum == 0 and vim.v.lnum or vim.v.relnum
  return pad_string(tostring(cur_num), line_number_width() + 1, 'right')
end

local function get_signs()
  local buffer = vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win()) -- vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local lnum = vim.v.lnum

  local signs = {}
  local extmarks = vim.api.nvim_buf_get_extmarks(buffer, -1, { lnum - 1, 0 }, { lnum - 1, -1 }, { details = true, type = 'sign' })
  for _, extmark in pairs(extmarks) do
    signs[#signs + 1] = {
      name = extmark[4].sign_hl_group or '',
      text = extmark[4].sign_text,
      texthl = extmark[4].sign_hl_group,
      priority = extmark[4].priority,
    }
  end

  return signs
end

local function get_sign_from_name(signs, name)
  local desired_sign
  for _, sign in ipairs(signs) do
    if sign.name:find(name) and desired_sign == nil then
      desired_sign = sign
    end
  end

  return desired_sign
end

-- Print sign
-- Expects sign table with texthl and text
local function print_sign(sign)
  return sign and highlight_text(sign.texthl, sign.text) or '  '
end

vim.opt.number = false
_G.render_statuscol = function()
  if vim.bo.filetype == 'neo-tree' then
    return ''
  end

  local signs = get_signs()
  local git_sign = get_sign_from_name(signs, 'GitSigns') or { texthl = 'StatusColumnBorder', text = '┃ ' }

  if vim.v.virtnum ~= 0 then
    return '  ' -- diagnostic sign
      .. pad_string(' ', line_number_width() + 1, 'right')
      .. ' '
      .. highlight_text(git_sign.texthl, '┃ ')
      .. '  '
  end

  return print_sign(get_sign_from_name(signs, 'DiagnosticSign'))
    .. get_line_number()
    .. ' '
    .. print_sign(git_sign)
    .. get_fold(vim.v.lnum)
    .. ' '
end
vim.o.statuscolumn = '%{%v:lua.render_statuscol()%}'
