return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('treesitter-auto-install', { clear = true }),
      callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
        if not pcall(vim.treesitter.language.add, lang) then
          local ok, parsers = pcall(require, 'nvim-treesitter.parsers')
          if ok and parsers[lang] then
            vim.cmd('TSInstall ' .. lang)
          end
          return
        end

        -- Experimental: treesitter-based indentation (from nvim-treesitter)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
