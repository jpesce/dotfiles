setlocal foldlevel=1
setlocal iskeyword+=-

" Use everything inside double quotes (") when jumping to tag
nnoremap <buffer> <C-]> vi"<C-]>

augroup auto_generate_ctags
    autocmd! * <buffer>
    autocmd BufWritePost <buffer> silent! !ctags -R &
augroup END
