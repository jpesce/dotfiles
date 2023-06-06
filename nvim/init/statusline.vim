set fillchars+=stl:\ ,stlnc:\  " Don't fill statusline with chars

" Show only one statusline for the whole window
set laststatus=3

" Status line shows filename and line:column
function! Statusline() abort
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
