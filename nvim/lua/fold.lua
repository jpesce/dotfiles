local o = vim.opt

o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldcolumn = "0"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldenable = true
o.fillchars = o.fillchars + "foldclose:▸" + "foldopen:▾" + "foldsep: "

function _G.fold_text()
  return vim.fn.getline(vim.v.foldstart) .. " ⋯"
end
o.foldtext = 'v:lua.fold_text()'
o.fillchars = o.fillchars + "fold: "

-- Waiting for https://github.com/neovim/neovim/pull/20750 to highlight fold lines
