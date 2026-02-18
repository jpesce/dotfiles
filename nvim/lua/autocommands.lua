-- AUTOCOMMANDS
-- YANK HIGHTLIGHT {{{
--  Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-on-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})
-- }}}

-- CURSOR RESOTRATION {{{
--  Restore last cursor position when reopening a file
vim.api.nvim_create_autocmd('BufRead', {
  desc = 'Restore last cursor position when reopening a file',
  callback = function(opts)
    vim.api.nvim_create_autocmd('BufWinEnter', {
      once = true,
      buffer = opts.buf,
      callback = function()
        local ft = vim.bo[opts.buf].filetype
        local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
        if not (ft:match 'commit' and ft:match 'rebase') and last_known_line > 1 and last_known_line <= vim.api.nvim_buf_line_count(opts.buf) then
          vim.api.nvim_feedkeys([[g`"]], 'nx', false)
        end
      end,
    })
  end,
})
-- }}}
-- PROJECT CONFIG {{{
--  Load project-specific config from projects/ directory based on cwd name
--  e.g. ~/Projects/miu/ loads ~/.config/nvim/projects/miu.lua
vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Load project-specific config',
  group = vim.api.nvim_create_augroup('project-config', { clear = true }),
  once = true,
  callback = function()
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    local config_file = vim.fn.stdpath 'config' .. '/projects/' .. project_name .. '.lua'
    if vim.fn.filereadable(config_file) == 1 then
      dofile(config_file)
    end
  end,
})
-- }}}
-- vim: foldmethod=marker
