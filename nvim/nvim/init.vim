" Set <leader> to space
let mapleader = " "

" Source local vimrc
" Warning: scurity risk - God have mercy on me
set exrc
set secure


" Extra mappings {{{
" More previous `[`, next `]` and toggle `y` mappings
packadd vim-unimpaired
" Add and change surrounding brackets, parenthesis and tags
packadd vim-surround
" Add and remove comments with gc
packadd vim-commentary
" Y yanks to the end of the line
nnoremap Y y$
" }}}

" Cheatsheet {{{
" Cheat cheat with <leader>?
packadd vim-cheat40
" Use custom cheat sheet
let g:cheat40_use_default = 0
" }}}

" Plugins {{{
" `%` recognize language-specific words
packadd vim-matchup
" Don't replace status line with the matching term when it's offscreen
let g:matchup_matchparen_offscreen = {}

" File explorer
"packadd vim-dirvish
packadd vim-vinegar

" FZF
packadd fzf.vim
set rtp+=/usr/local/opt/fzf
nno <silent> <Leader>f :Files<CR>
nno <silent> <Leader>b :Buffers<CR>
nno <silent> <Leader>s :BLines<CR>
nno <silent> <Leader>h :Helptags<CR>
" :Files includes hidden files
let $FZF_DEFAULT_COMMAND="rg --files --follow --hidden"
" :Rg includes hidden files and don't use Regex by default
command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden --fixed-strings ".shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview(),
  \ <bang>0)
" :Rge to grep with Regex
command! -bang -nargs=* Rge
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden ".shellescape(<q-args>),
  \ 1,
  \ fzf#vim#with_preview(),
  \ <bang>0)
" <Alt-A> to select all results and <Alt-D> to deselect
let $FZF_DEFAULT_OPTS.=" --bind 'alt-a:select-all,alt-d:deselect-all'"
" Minimal FZF colors
let g:fzf_colors =
    \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Search'],
      \ 'fg+':     ['fg', 'Normal'],
      \ 'bg+':     ['bg', 'Terminal'],
      \ 'hl+':     ['fg', 'Search'],
      \ 'info':    ['bg', 'Terminal'],
      \ 'border':  ['fg', 'NonText'],
      \ 'prompt':  ['fg', 'Comment'],
      \ 'pointer': ['bg', 'Terminal'],
      \ 'marker':  ['fg', 'WarningMsg'],
      \ 'spinner': ['fg', 'Normal'],
      \ 'header':  ['fg', 'Normal'] }

" Show buffer list on tabline. Who needs tabs anyway?
packadd vim-buftabline
" Show modifiers on tabline
let g:buftabline_indicators = 1


"packadd AutoComplPop

" Git
packadd vim-fugitive

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
" Don't use swap and backup files
set noswapfile nobackup
" Instead, keep undo history on a directory so you can always undo (U)
" even after the file is closed or the computer rebooted
set undofile
" Add undo breaks to characters
inoremap . .<C-g>u
inoremap , ,<C-g>u
inoremap ? ?<C-g>u
inoremap ! !<C-g>u
inoremap <Space> <Space><C-g>u
inoremap <CR> <CR><C-g>u
" }}}

" Autocompletion {{{
" When completing commands, first complete as much as possible and on the next
" <tab>, cycle through options
set wildmode=longest:full,full
" Use CTRL-j and CTRL-k to navigate the results
cno <expr> <C-j> pumvisible() ? "<C-n>" : "<C-j>"
cno <expr> <C-k> pumvisible() ? "<C-p>" : "<C-k>"
" Enable OMNI Completion (<C-X><X-O) for known language keywords
set omnifunc=syntaxcomplete#Complete
" Don't insert the first item of the menu automatically
set completeopt=menuone,noselect
" Don't show messages on ruler about number of completions
set shortmess+=c
" CTRL-j and CTRL-k navigate the results
ino <expr> <C-j> pumvisible() ? "<C-n>" : "<C-j>"
ino <expr> <C-k> pumvisible() ? "<C-p>" : "<C-k>"
inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() . "\<cr>" : "\<cr>"
" <Enter> select the item
" ino <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
" cno <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
" Auto complete when typing
packadd asyncomplete.vim
packadd asyncomplete-buffer.vim
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
  \ 'name': 'buffer',
  \ 'allowlist': ['*'],
  \ 'completor': function('asyncomplete#sources#buffer#completor'),
  \ 'config': {
  \    'max_buffer_size': 5000000,
  \  },
  \ }))
packadd asyncomplete-file.vim
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
  \ 'name': 'file',
  \ 'allowlist': ['*'],
  \ 'priority': 10,
  \ 'completor': function('asyncomplete#sources#file#completor')
  \ }))
packadd asyncomplete-omni.vim
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
  \ 'name': 'omni',
  \ 'allowlist': ['*'],
  \ 'completor': function('asyncomplete#sources#omni#completor'),
  \ 'config': {
  \   'show_source_kind': 1,
  \ },
  \ }))
" Auto generate ctags when saving
au BufWritePost *.js,*.ts,*.json,*.jsonc silent! !ctags -R &
packadd asyncomplete-tags.vim
au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
    \ 'name': 'tags',
    \ 'allowlist': ['js', 'ts', 'json', 'jsonc'],
    \ 'completor': function('asyncomplete#sources#tags#completor'),
    \ 'config': {
    \    'max_file_size': 50000000,
    \  },
    \ }))
" }}}

" Search {{{
" If the term has uppercase, search with case sensitivity, otherwise ignore case
set smartcase ignorecase
" <C-L> clears search and rerenders syntax
nno <C-l> :nohlsearch<CR>:diffupdate<CR>:syntax sync fromstart<CR><C-l>
" }}}

" Indentation {{{
" Tab size is 2 spaces for tabs, spaces and shift indentation command (< and >)
set tabstop=2 softtabstop=2 shiftwidth=2
" Try to automatically indent next lines smartly
set smartindent
" Convert tab into spaces
set expandtab
" In visual mode, when indenting with < >, continue with the selection
vno > >gv
vno < <gv
" }}}

" Line width {{{
" Responsible line breaking at column 80. Don't automatically break text upon
" reaching it. Use `gq` where and when needed.
set textwidth=80
set formatoptions-=t
" }}}

" Visuals {{{
" Color scheme
colorscheme essential2
" Show relative line numbers except for the current line
set relativenumber number
" Hide vim intro
set shortmess+=I
" Redefine filling characters on vertical split and status line
set fillchars+=vert:│
set fillchars+=stl:-,stlnc:-

" Ruler displays only current line and column
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
" }}}

" Folding {{{
set foldmethod=syntax
" Start unfolded
set foldlevelstart=99
" Folds are displayed with only the line content and a plus sign
let FoldText = { -> getline(v:foldstart) . ' ﹢ '  }
set foldtext=FoldText()
" }}}

" File explorer (:Exp) {{{
" Don't show info on top
let g:netrw_banner = 0
" Use tree style by default
let g:netrw_liststyle=3
" }}}

" Grep {{{
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

" Linting {{{
packadd ale
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
      \ 'css': ['stylelint'],
      \ 'json': ['eslint'], 'jsonc': ['eslint'], 'json5': ['eslint']
      \ }
" Define fixers for :ALEFix
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'css': ['stylelint'],
      \ 'json': ['eslint'], 'jsonc': ['eslint'], 'json5': ['eslint']
      \ }
" }}}

" Visual selection mappings {{{
" Escape special characters in a string
" Useful for using in search & replace, grep, etc
function! EscapeString (string)
  let l:string=a:string
  " Escape regex characters
  let l:string = escape(l:string, '^$.*\/~[]#\" ')
  " Escape line endings
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

" Replace
vmap <Leader>r <Esc>:%s/<C-r>=EscapeString(GetVisualSelection())<CR>//g<left><left>
" Grep
vmap <Leader>g <Esc>:Rg <C-r>=GetVisualSelection()<CR><CR>
" }}}
