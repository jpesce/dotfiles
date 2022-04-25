" Escape special characters in a string
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

" Replace selection
vmap <Leader>r <Esc>:%s/<C-r>=EscapeString(GetVisualSelection())<CR>//g<left><left>
" Grep selection
vmap <Leader>g <Esc>:Rg <C-r>=GetVisualSelection()<CR><CR>
