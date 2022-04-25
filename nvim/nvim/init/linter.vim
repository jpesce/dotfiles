packadd ale
" Always show sign columns
set signcolumn=yes
" Don't highlight the code
let g:ale_set_highlights = 0
" Custom signs
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'

" Define linters
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \ 'ruby': ['rubocop'],
      \ 'javascript': ['eslint'], 'typescript': ['eslint'],
      \ 'css': ['stylelint'],
      \ }

" Define fixers (:ALEFix)
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['eslint', 'prettier'], 'typescript': ['eslint', 'prettier'],
      \ 'css': ['stylelint'],
      \ 'json': ['jq']
      \ }
