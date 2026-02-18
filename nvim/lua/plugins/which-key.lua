return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    require('which-key').setup()

    -- Normal mode
    require('which-key').add {
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]iagnostic' },
      { '<leader>g', group = '[G]it' },
      { '<leader>l', group = '[L]ist' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
    }
    -- Visual mode
    require('which-key').add {
      { '<leader>s', group = '[S]earch', mode = 'v' },
      { '<leader>s_', hidden = true, mode = 'v' },
    }
  end,
}
