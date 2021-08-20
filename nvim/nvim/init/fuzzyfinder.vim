packadd fzf.vim
set rtp+=/usr/local/opt/fzf
" <Alt-A> to select all results and <Alt-D> to deselect
let $FZF_DEFAULT_OPTS.=" --bind 'alt-a:select-all,alt-d:deselect-all'"

nno <silent> <Leader>f :Files<CR>
nno <silent> <Leader>b :Buffers<CR>
nno <silent> <Leader>h :Helptags<CR>
" Search on all buffers
nno <silent> <Leader>s :BLines<CR>

" :Files includes hidden (.) files
let $FZF_DEFAULT_COMMAND="rg --files --follow --hidden"

" :Rg
" Includes hidden files
" Disable regex
command! -bang -nargs=* Rg
      \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden --fixed-strings ".shellescape(<q-args>),
      \ 1, fzf#vim#with_preview(), <bang>0)

" :Rge
" Use regex
command! -bang -nargs=* Rge
      \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case --hidden ".shellescape(<q-args>),
      \ 1, fzf#vim#with_preview(), <bang>0)

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

