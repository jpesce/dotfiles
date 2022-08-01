" Show only one statusline for the whole window
set laststatus=3

" Status line is filename and line:column
function! Statusline() abort
  hi StatusLine ctermfg=white ctermbg=NONE cterm=bold
  let l:statusline ='%#StatusLine#'
  let l:statusline.=' %f %m '
  let l:statusline.='%#StatusLineNC#'
  let l:statusline.='%='
  let l:statusline.='%#StatusLine#'
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
set statusline=%!Statusline()

" Set status line as active or inactive when changing windows
augroup set_active_statusline
  autocmd!
  autocmd WinEnter,FocusGained * :setlocal statusline=%!Statusline()
  autocmd WinLeave,FocusLost * :setlocal statusline=%!StatuslineNC()
augroup END
