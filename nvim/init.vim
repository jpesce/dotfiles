" Plugins for consideration:
" https://github.com/wellle/targets.vim

" Set <leader> to space
let mapleader = " "

" Source project-specific vimrc on `.vim/vimrc` project root
packadd vim-prj | let g:prj_config_path = ".vim/vimrc"

" Remove trailing lines and white spaces on exit
let g:remove_white_spaces#blacklist = ['markdown'] " Except on these filetypes
augroup remove_white_spaces_on_exit
  autocmd!
  autocmd BufWritePre * if index(g:remove_white_spaces#blacklist, &ft) < 0 | %s/\s\+$//e | endif
augroup END

" Autogenerate ctags when writing some files
augroup auto_manage_tags
  autocmd!
  autocmd BufWritePost *.json,*.jsonc silent! !ctags -R &
augroup END

" Leave only current (B)uffer open
nnoremap <Leader>B :%bd<bar>e#<bar>bd#<CR>

" Navigate tmux panes and vim splits with <Opt-hjkl> (aka Alt aka Meta)
packadd vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <A-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <A-j> :TmuxNavigateDown<CR>
nnoremap <silent> <A-k> :TmuxNavigateUp<CR>
nnoremap <silent> <A-l> :TmuxNavigateRight<CR>


" Fairly sensible Defaults {{{
set splitright splitbelow " Defaults splitting to the right and below
set lazyredraw            " Don't update the display when running macros
set path+=**              " Add project's directories to path to make it easy to :find files
set clipboard=unnamed     " Yanking, deleting and pasting work with the clipboard
" }}}

" Visuals {{{
" Color scheme
colorscheme essential

" Show buffer list on tabline. Who needs tabs anyway?
packadd vim-buftabline
" Show modified flag
let g:buftabline_indicators = 1
" Only show if there is more than one open buffer
let g:buftabline_show = 1

" Show relative line numbers except for the current line
set relativenumber number
" Cursor always in the middle
set scrolloff=1000

" Hide vim intro
set shortmess+=I

" Redefine filling characters on vertical split and status line
set fillchars+=vert:│
set fillchars+=stl:\ ,stlnc:\  " Hide status line fill

" Statuscolumn
" 1. Relative line number or actual line number if we're in the current line
" 2. Sign column
" 3. Caret right if fold is open, caret down if fold is closed
let &statuscolumn='%=%{line(".") == v:lnum ? v:lnum : v:relnum}%s%{foldlevel(v:lnum) > foldlevel(v:lnum - 1) ? (foldclosed(v:lnum) == -1 ? "▶ " : "▼ ") : "  " }'

" Statusline
source $HOME/.config/nvim/init/statusline.vim
" }}}

" Folding {{{
set foldmethod=syntax
" Start unfolded
set foldlevelstart=99

" Commenting because foldcolumn behavior currently being set by statuscolumn
" Show fold column with only the fold indicator
" set foldcolumn=1
" set fillchars+=foldclose:▸,foldopen:▾,foldsep:\  " Hide fold separators on fold column

" Folds are displayed with only the line content and the fill chars
let FoldText = { -> getline(v:foldstart) . ' '  }
set foldtext=FoldText()
set fillchars+=fold:─  " Fold characters after fold text
" Waiting for this PR to highlight folded lines:
" https://github.com/neovim/neovim/pull/20750
" }}}

" Backup {{{
" Don't use swapfiles
set noswapfile
" Keep undo history so you can always undo (U) even when file is closed
set undofile
" Add undo breaks to characters
inoremap . .<C-g>u
inoremap , ,<C-g>u
inoremap ? ?<C-g>u
inoremap ! !<C-g>u
inoremap <Space> <Space><C-g>u
inoremap <CR> <CR><C-g>u
" }}}

" Extra file type support {{{
" Native support for jsonc is better than polyglot
let g:polyglot_disabled = ['jsonc']
packadd vim-polyglot
" }}}

" Extensions {{{
" More previous `[`, next `]` and toggle `y` mappings
packadd vim-unimpaired
" Add and change surrounding brackets, parenthesis and tags
packadd vim-surround
" Add and remove comments with gc
packadd vim-commentary
" Add file commands such as :Rename :Move :Delete
packadd vim-eunuch
" `%` recognize language-specific words
packadd vim-matchup | let g:matchup_matchparen_offscreen = {}
" }}}

" Search {{{
" If the term has uppercase, search with case sensitivity, otherwise ignore case
set smartcase ignorecase
" <C-L> clears search and rerenders syntax
nno <C-l> :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
" }}}

" Indent {{{
" Use 2 spaces for tabs, spaces and shift indentation command (< and >)
set tabstop=2 softtabstop=2 shiftwidth=2
" When indenting, round the indent level to a multiple of shiftwidth
set shiftround
" Try to automatically indent next lines smartly
set smartindent
" Convert tab into spaces
set expandtab
" In visual mode, when indenting with < >, continue with the selection
vno > >gv
vno < <gv
" }}}

" Line width {{{
" Responsible line breaking at column 80.
set textwidth=80
" Don't automatically break text upon reaching it. Use `gq` where and when needed.
set formatoptions-=t
" }}}

" Grep {{{
source $HOME/.config/nvim/init/grep.vim
" }}}

" File explorer (:Exp) {{{
" Extend file explorer
packadd vim-vinegar
" Don't show info on top
let g:netrw_banner = 0
" Use tree style by default
let g:netrw_liststyle=3
" Fixed width for :Lex
let g:netrw_winsize = -30
" Enable mouse on netrw
function! NetrwMouseOn()
  set mouse=n
endfunction
function! NetrwMouseOff()
  set mouse=
endfunction

augroup enable_mouse_on_netrw
  autocmd!
  autocmd FileType netrw :call NetrwMouseOn()
  autocmd FileType netrw au BufEnter <buffer> :call NetrwMouseOn()
  autocmd FileType netrw au BufLeave <buffer> :call NetrwMouseOff()
  " Map left click to <Return> so it opens directories and files
  autocmd FileType netrw nmap <buffer> <LeftMouse> <LeftMouse> <CR>
augroup END
" }}}

" Fuzzy finder {{{
source $HOME/.config/nvim/init/fuzzyfinder.vim
" }}}

" LSP {{{
set signcolumn=yes
luafile $HOME/.config/nvim/init/lsp.lua
" }}}

" Completion {{{
" When completing commands, first complete as much as possible and on the next
" <tab>, cycle through options
set wildmode=longest:full,full
" Don't insert the first item of the menu automatically
set completeopt=menuone,noselect
" Don't show messages on ruler about number of completions
set shortmess+=c

" Navigate command completions with vim keys
" cnoremap <expr> <Down> pumvisible()  ? "<C-n>" : "<C-j>"
" cnoremap <expr> <Up> pumvisible()    ? "<C-p>" : "<C-k>"
" cnoremap <expr> <Right> pumvisible() ? "<C-y>" : "<C-k>"
" cnoremap <expr> <Left> pumvisible()  ? "<C-e>" : "<C-k>"

" Enable OMNI Completion (<C-X><X-O) for known language keywords
set omnifunc=syntaxcomplete#Complete

" Autocompletion
luafile $HOME/.config/nvim/init/autocomplete.lua
" }}}

" Git integration {{{
packadd vim-fugitive

" Get diff in a three-way vertical split
nnoremap <leader>gd :Gvdiffsplit!<CR>
" Get change from left (h) pane
nnoremap <leader>gdh :diffget //2<CR>
" Get change from right (l) pane
nnoremap <leader>gdl :diffget //3<CR>
" }}}

" Visual selection operations {{{
source $HOME/.config/nvim/init/visual.vim
" }}}

" Zettlekasten commands {{{
source $HOME/.config/nvim/init/zettelkasten.vim
" }}}

" Color scheme design {{{
" Show/hide highlight stack with :HLT!
packadd vim-hilinks
" }}}

" Sonic Pi {{{
packadd vim-sonic-pi
" }}}
