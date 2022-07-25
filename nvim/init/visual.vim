" Escape special characters in a string
function! EscapeString (string)
  let l:string=a:string
  " Escape regex characters
  let l:string = escape(l:string, '^$.*\/~[]#\" ')
  " Escape line endings
  let l:string = substitute(l:string, '\n', '\\n', 'g')
  return l:string
endfunction

function! GetVisualSelection() range
  " Save current register content
  let l:current_register_content = @"
  " Copy selection to the register
  normal! gv""y
  " Save selection to variable
  let l:selection = @"
  " Restore register to old content
  let @" = l:current_register_content

  return l:selection
endfunction

" Replace selection
vmap <Leader>r <Esc>:%s/<C-r>=EscapeString(GetVisualSelection())<CR>//g<left><left>
" Grep selection
vmap <Leader>g <Esc>:Rg <C-r>=GetVisualSelection()<CR><CR>
