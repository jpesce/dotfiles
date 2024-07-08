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

local function get_line_number()
  local cur_num

  -- Return a visual placeholder if line is wrapped
  if vim.v.virtnum ~= 0 then
    return '-'
  end

  -- Get absolute lnum if is current line, else relnum
  cur_num = vim.v.relnum == 0 and vim.v.lnum or vim.v.relnum
  cur_num = tostring(cur_num)

  return pad_string(cur_num, 4, 'right')
end

local function get_signs()
  local buffer = vim.api.nvim_win_get_buf(vim.g.statusline_winid)

  return vim.tbl_map(function(sign)
    return vim.fn.sign_getdefined(sign.name)[1]
  end, vim.fn.sign_getplaced(buffer, { group = '*', lnum = vim.v.lnum })[1].signs)
end

-- Print sign
-- Expects sign table with texthl and text
local function print_sign(sign)
  return sign and highlight_text(sign.texthl, sign.text) or '  '
end

vim.opt.number = false
_G.get_statuscol = function()
  local diag_sign
  for _, sign_table in ipairs(get_signs()) do
    if sign_table.name:find 'DiagnosticSign' and diag_sign == nil then
      diag_sign = sign_table
    end
  end

  return print_sign(diag_sign) .. get_line_number() .. ' ' .. get_fold(vim.v.lnum) .. ' '
end
vim.o.statuscolumn = '%!v:lua.get_statuscol()'
