" Add folding to headings
function! MarkdownFolds()
  let thisline = getline(v:lnum)
  if match(thisline, '^###') >= 0
    return ">3"
  elseif match(thisline, '^##') >= 0
    return ">2"
  elseif match(thisline, '^#') >= 0
    return ">1"
  else
    return "="
  endif
endfunction
setlocal foldmethod=expr
setlocal foldexpr=MarkdownFolds()

" Add c surround movement. For example:
" V to select line
" S to start surround
" c to add code block signs around it (``` ```)
let b:surround_{char2nr('c')} = "```\1language: \1\r```"
