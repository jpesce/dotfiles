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
set statusline=%!Statusline()

" Set status line as active or inactive when changing windows
augroup set_active_statusline
  autocmd!
  autocmd WinEnter * :setlocal statusline=%!Statusline()
  autocmd WinLeave * :setlocal statusline=%!StatuslineNC()
augroup END

