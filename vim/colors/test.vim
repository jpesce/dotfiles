let s:a = [1,2,3,4]
let s:b = ""

if type(s:a) == 3 | echo "OK" | endif
if type(s:b) == 3 | echo "OK" | endif

fun <sid>hi(group, fg, bg, ...)
  let l:attr = get(a:, 1, "")
  let l:guisp = get(a:, 2, "")
  if type(l:guisp) == 3 | let l:guisp = l:guisp[0] | endif
  if type(a:fg) == 3 | let l:guifg = a:fg[0] | endif
  if type(a:fg) == 3 | let l:ctermfg = a:fg[1] | endif
  if type(a:bg) == 3 | let l:guibg = a:bg[0] | endif
  if type(a:bg) == 3 | let l:ctermbg = a:bg[1] | endif

  if type(a:fg) == 3 | let l:teste = a:fg[0] | endif
  if exists("l:guifg") | exec "hi " . a:group . " guifg=" . l:guifg | endif
  if exists("l:guibg") | exec "hi " . a:group . " guibg=" . l:guibg | endif
  if exists("l:ctermfg") | exec "hi " . a:group . " ctermfg=" . l:ctermfg | endif
  if exists("l:ctermbg") | exec "hi " . a:group . " ctermbg=" . l:ctermbg | endif
  if l:attr != "" | exec "hi " . a:group . " gui=" . l:attr . " cterm=" . l:attr | endif
  if l:guisp != "" | exec "hi " . a:group . " guisp=" . l:guisp | endif
endfun

call <sid>hi("Normal", ["#000000", 00], "")
