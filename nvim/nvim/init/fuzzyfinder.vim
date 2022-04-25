packadd fzf.vim
set rtp+=/usr/local/opt/fzf

" Build quickfix list from result with <CTRL+Q>
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
endfunction

let g:fzf_action = {
  \ 'alt-q': function('s:build_quickfix_list'),
  \ 'alt-v': 'vsplit'
  \ }
" <Alt-A> to select all results and <Alt-D> to deselect
let $FZF_DEFAULT_OPTS.=" --bind 'alt-a:select-all,alt-d:deselect-all'"

nno <silent> <Leader>f :Files<CR>
nno <silent> <Leader>b :Buffers<CR>
nno <silent> <Leader>h :Helptags<CR>
" Search on current buffer
nno <silent> <Leader>s :BLines<CR>

" :Files and :Rg
" Include hidden (.) files
" Remove .git, tags and node_modules
let $FZF_DEFAULT_COMMAND="rg --files --follow --hidden --glob '!{.git,tags,**/node_modules}' "
let g:fuzzy_finder#rg_command = "rg --column --line-number --no-heading --color=always --smart-case --hidden --glob '!{.git,tags,**/node_modules}' "

" :Rg
" Disable regex
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(g:fuzzy_finder#rg_command . " --fixed-strings -- " . shellescape(<q-args>),
      \ 1, fzf#vim#with_preview(), <bang>0)

" :Rge
" Use regex
command! -bang -nargs=* Rge
      \ call fzf#vim#grep(g:fuzzy_finder#rg_command . " -- " . shellescape(<q-args>),
      \ 1, fzf#vim#with_preview(), <bang>0)

" :Rgi
" Ripgrep interactively so every new thing you type on fzf is searched again on
" ripgrep
function! InteractiveRipgrepFzf(query, fullscreen)
  let command_fmt = g:fuzzy_finder#rg_command . ' -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang Rgi call InteractiveRipgrepFzf(<q-args>, <bang>0)

" Minimal colors
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
