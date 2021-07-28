" Set <leader> to space
let mapleader = " "

" Extra mappings {{{
" More previous `[`, next `]` and toggle `y` mappings
packadd vim-unimpaired
" Add and change surrounding brackets, parenthesis and tags
packadd vim-surround
" Add and remove comments with gc
packadd vim-commentary
" }}}

" Plugins {{{
" Cheat cheat with <leader>?
packadd vim-cheat40
" Use custom cheat sheet
let g:cheat40_use_default = 0

" `%` recognize language-specific words
packadd vim-matchup
" Don't replace status line with the matching term when it's offscreen
let g:matchup_matchparen_offscreen = {}

" File explorer
"packadd vim-dirvish
packadd vim-vinegar

" Extra FZF integrations
packadd fzf.vim
set rtp+=/usr/local/opt/fzf
nno <silent> <Leader>f :FZF<CR>
nno <silent> <Leader>b :Buffers<CR>
nno <silent> <Leader>s :BLines<CR>
" Search includes hidden files and exclude node_modules and .git
let $FZF_DEFAULT_COMMAND="rg --files --follow --no-ignore-vcs --hidden --glob '!{**/node_modules,.git/*}'"
let $FZF_DEFAULT_OPTS.=" --bind 'alt-a:select-all,alt-d:deselect-all'"

" Show buffer list on tabline. Who needs tabs anyway?
packadd vim-buftabline
" Show modifiers on tabline
let g:buftabline_indicators = 1

" Auto complete when typing
"packadd AutoComplPop

" Git
packadd vim-fugitive

" Code linting and fixing
packadd ale
" }}}

" Color scheme {{{
" set termguicolors
packadd vim-yami
" Toolkit for color scheme design
packadd vim-colortemplate

" Show/hide highlight stack with :HLT!
packadd vim-hilinks
" }}}

" File type support {{{
packadd vim-polyglot
packadd vim-jsonc
" }}}

" Sensible Defaults {{{
set splitright splitbelow    " Defaults splitting to the right and below
set hidden                   " Buffers are only hidden, not closed
set lazyredraw               " Don't update the display while running macros
" }}}

" Not so sensible defaults :-) {{{
" Recursively add project's directories to path to make it easy to :find files
set path+=**
" Yanking, deleting and pasting work with the clipboard
set clipboard=unnamed
" Cursor always in the middle
set scrolloff=1000
" Remove trailing lines and white spaces on exit
autocmd BufWritePre * %s/\s\+$//e
" Consider '-' part of a word
set iskeyword+=-
" Don't use swap and backup files
set noswapfile nobackup
" Instead, keep undo history on a directory so you can always undo (U)
" even after the file is closed or the computer rebooted
set undofile
" When completing commands, first complete as much as possible, on the next
" <tab>, cycle through options
set wildmode=longest:full,full
" }}}

" Autocompletion {{{
" Enable OMNI Completion (<C-X><X-O) for known language keywords
set omnifunc=syntaxcomplete#Complete
" Don't insert the first item of the menu automatically
set completeopt=menuone,noselect
" Don't show messages on ruler about number of completions
set shortmess+=c
" CTRL-j and CTRL-k navigate the results
ino <expr> <C-j> pumvisible() ? "<C-n>" : "<C-j>"
ino <expr> <C-k> pumvisible() ? "<C-p>" : "<C-k>"
cno <expr> <C-j> pumvisible() ? "<C-n>" : "<C-j>"
cno <expr> <C-k> pumvisible() ? "<C-p>" : "<C-k>"
" <Enter> select the item
" ino <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
" cno <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
" }}}

" Search {{{
" If the term has uppercase, search with case sensitivity, otherwise ignore case
set smartcase ignorecase
" <C-L> clears search and rerenders syntax
" https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim
nno <C-l> :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
" }}}

" Indentation {{{
" Tab size is 2 spaces for tabs, spaces and shift indentation command (< and >)
set tabstop=2 softtabstop=2 shiftwidth=2
" Try to automatically indent next lines smartly
set smartindent
" Convert tab into spaces
set expandtab
" When indenting with < > in visual mode continue with the selection
vno > >gv
vno < <gv
" }}}

" Line width {{{
" Responsible line breaking at column 80. Don't automatically break text upon
" reaching it. Use `gq` where and when needed.
set textwidth=80
set formatoptions-=t
" Other options:
" Show a colored column at column 81
"set colorcolumn=81
" Highlight text that exceeds 80 characters
"match ColorColumn "\%>80v.\+"
" }}}

" Visuals {{{
" Color scheme
colorscheme essential2
" Show relative line numbers except for the current line
set relativenumber number
" Hide vim intro
set shortmess+=I
" Redefine filling characters on vertical split and status line
set fillchars+=vert:│            "│ vertical line
set fillchars+=stl:-,stlnc:-    " ─ horizontal line

" Ruler is only current line and column
set rulerformat=%7(%l:%c%)
" Status line is filename and line:column
function! Statusline() abort
  hi StatusLine ctermfg=DarkGray
  hi ActiveStatusLine ctermfg=DarkGray
  let l:statusline ='%#ActiveStatusLine#'
  let l:statusline.=' %f %m '
  let l:statusline.='%#StatusLineNC#'
  let l:statusline.='%='
  let l:statusline.='%#ActiveStatusLine#'
  let l:statusline.='  ☰ %l:%c  '
  return l:statusline
endfunction
function! StatuslineNC() abort
  let l:statusline ='%#StatusLineNC#'
  let l:statusline.=' %f %m '
  let l:statusline.='%='
  let l:statusline.='  ☰ %l:%c  '
  return l:statusline
endfunction
:set statusline=%!Statusline()
augroup set-active-statusline
  autocmd!
  autocmd WinEnter * :setlocal statusline=%!Statusline()
  autocmd WinLeave * :setlocal statusline=%!StatuslineNC()
augroup END
"set statusline+=\ \ %f\ %m\ \     " Filename and %m modified indicator
"set statusline+=%#StatusLine#%=               " Spacer
"set statusline+=%#StatusLineText#
"set statusline+=\ \ ☰\ %l:%c\ \  " Line and column
" }}}

" Folding {{{
set foldmethod=syntax
" Start unfolded
set foldlevelstart=99
" Fold text is only the line content and a plus sign
let FoldText = { -> getline(v:foldstart) . ' ﹢ '  }
set foldtext=FoldText()
" }}}

" File explorer (:Vexp) {{{
" Don't show info on top
let g:netrw_banner = 0
" Resize splits to 20%
"let g:netrw_winsize = 20
" Use tree style by default
let g:netrw_liststyle=3
" }}}

" Grepping {{{
" Use ripgrep as :grep program
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --fixed-strings
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
" Grep silently
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep!'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep!' : 'lgrep'
autocmd QuickFixCmdPost *grep* redraw!
autocmd QuickFixCmdPost *grep* copen
" }}}

" ALE code linting {{{
" Always show sign columns
set signcolumn=yes
" Don't highlight the code
let g:ale_set_highlights = 0
" Prettier signs
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'
" Define linters manually
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \ 'ruby': ['rubocop'],
      \ 'javascript': ['eslint'],
      \ 'css': ['stylelint']
      \ }
" Define fixers for :ALEFix
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'css': ['stylelint'],
      \ 'json': ['jq'], 'jsonc': ['jq']
      \ }
" }}}

" Escape special characters in a string
" Useful for using in search & replace, grep, etc
function! EscapeString (string)
  let l:string=a:string
  " Escape regex characters
  let l:string = escape(l:string, '^$.*\/~[]#\" ')
  " Escape the line endings
  let l:string = substitute(l:string, '\n', '\\n', 'g')
  return l:string
endfunction

" Return the current visual selection
function! GetVisualSelection() range
  " Save the current register and clipboard
  let l:current_reg = getreg('"')
  let l:current_regtype = getregtype('"')
  let l:current_clipboard = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let l:selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', l:current_reg, l:current_regtype)
  let &clipboard = l:current_clipboard

  return selection
endfunction

vmap <Leader>r <Esc>:%s/<c-r>=EscapeString(GetVisualSelection())<cr>//g<left><left>
vmap <Leader>g <Esc>:grep "<c-r>=EscapeString(GetVisualSelection())<cr>"
