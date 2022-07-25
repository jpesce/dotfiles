" Auto complete when typing
packadd asyncomplete.vim
packadd asyncomplete-buffer.vim
call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
      \ 'name': 'buffer',
      \ 'allowlist': ['*'],
      \ 'completor': function('asyncomplete#sources#buffer#completor'),
      \ 'config': {
        \    'max_buffer_size': 5000000,
        \  },
        \ }))

packadd asyncomplete-file.vim
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
      \ 'name': 'file',
      \ 'allowlist': ['*'],
      \ 'priority': 10,
      \ 'completor': function('asyncomplete#sources#file#completor')
      \ }))

packadd asyncomplete-omni.vim
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
      \ 'name': 'omni',
      \ 'allowlist': ['*'],
      \ 'completor': function('asyncomplete#sources#omni#completor'),
      \ 'config': {
        \   'show_source_kind': 1,
        \ },
        \ }))

packadd asyncomplete-tags.vim
autocmd User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
      \ 'name': 'tags',
      \ 'allowlist': ['js', 'ts', 'json', 'jsonc'],
      \ 'completor': function('asyncomplete#sources#tags#completor'),
      \ 'config': {
        \    'max_file_size': 50000000,
        \  },
        \ }))
