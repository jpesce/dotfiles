return {
  'echasnovski/mini.nvim',
  config = function()
    -- Move visual selection with <M-hjkl>
    require('mini.move').setup {
      mappings = {
        -- Disable for normal mode
        line_left = '',
        line_right = '',
        line_down = '',
        line_up = '',
      },
    }

    -- Autopairs
    require('mini.pairs').setup()

    -- Better around/inside textobjects
    --
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    -- Go forward/backward with square brackets
    --
    -- - [B [b ]b ]B - Buffer
    -- - [D [d ]d ]D - Diagnostic
    require('mini.bracketed').setup()

    -- Show buffers in tabline
    require('mini.tabline').setup()
  end,
}
