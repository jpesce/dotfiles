-- TODO: Maybe try https://github.com/windwp/nvim-projectconfig?

local g = vim.g

-- Source project-specific vimrc on `.vim/vimrc` project root
packer.use "emersonmx/vim-prj"
g.prj_config_path = ".vim/vimrc"
