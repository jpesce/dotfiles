set rtp+=/usr/local/opt/fzf

if exists('$TMUX')
  " Use tmux popup if possible
  let g:fzf_layout = { 'tmux': '-p90%,80%' }
else
  " Otherwise open in a window
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
endif

" Hide statusline when fzf is open
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Build quickfix list from selected items
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
endfunction

" Build location list from selected items
function! s:build_location_list(lines)
  call setloclist(win_getid(), map(copy(a:lines), '{ "filename": v:val }'))
  lopen
endfunction

let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-l': function('s:build_location_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

" <Opt-A> to select all results and <Opt-D> to deselect (Opt aka Alt aka Meta)
let $FZF_DEFAULT_OPTS.=" --bind 'alt-a:select-all,alt-d:deselect-all'"

" Find files
nno <silent> <Leader>f :Files<CR>
" Find buffer
nno <silent> <Leader>b :Buffers<CR>
" Search current buffer
nno <silent> <Leader>s :BLines<CR>

" File search {{{
" Include hidden (.) files
" Remove .git, tags and node_modules
let $FZF_DEFAULT_COMMAND="rg --files --follow --hidden --glob '!{.git,tags,**/node_modules}' "
" }}}

" Grep {{{
" Ripgrep options
let g:fuzzyfinder#rg_command ="rg --column --line-number --no-heading "
let g:fuzzyfinder#rg_command.="--smart-case --hidden --glob '!{.git,tags,**/node_modules}' "
let g:fuzzyfinder#rg_command.="--color=always --colors 'column:fg:white' --colors 'line:fg:white' --colors 'path:fg:7' --colors 'match:fg:black' --colors 'match:bg:16' "

" :Rg
" Disable regex
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(g:fuzzyfinder#rg_command . " --fixed-strings -- " . shellescape(<q-args>),
      \ 1, fzf#vim#with_preview(), <bang>0)

" :Rge
" Use regex
command! -bang -nargs=* Rge
      \ call fzf#vim#grep(g:fuzzyfinder#rg_command . " -- " . shellescape(<q-args>),
      \ 1, fzf#vim#with_preview(), <bang>0)

" :Rgi
" Ripgrep interactively so every new thing you type on fzf is searched again
" through ripgrep
function! InteractiveRipgrepFzf(query, fullscreen)
  let command_format = g:fuzzyfinder#rg_command . ' -- %s || true'
  let initial_command = printf(command_format, shellescape(a:query))
  let reload_command = printf(command_format, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rgi call InteractiveRipgrepFzf(<q-args>, <bang>0)
" }}}

" Minimal colors
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Search'],
      \ 'fg+':     ['fg', 'Normal'],
      \ 'bg+':     ['bg', 'Terminal'],
      \ 'hl+':     ['fg', 'Search'],
      \ 'info':    ['fg', 'Normal'],
      \ 'border':  ['fg', 'NonText'],
      \ 'prompt':  ['fg', 'Comment'],
      \ 'pointer': ['fg', 'Regular'],
      \ 'marker':  ['fg', 'WarningMsg'],
      \ 'spinner': ['fg', 'Normal'],
      \ 'header':  ['fg', 'Normal']
      \ }
