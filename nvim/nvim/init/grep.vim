" Use ripgrep as :grep program
if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading\ --fixed-strings
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Grep silently
cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() =~# '^grep')  ? 'silent grep!'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() =~# '^lgrep') ? 'silent lgrep!' : 'lgrep'

augroup redraw_and_open_quickfix_after_grep
  autocmd!
  autocmd QuickFixCmdPost *grep* redraw!
  autocmd QuickFixCmdPost *grep* copen
augroup END
