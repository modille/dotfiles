let g:neoterm_rspec_lib_cmd = 'rspec --color --format doc'

" nnoremap <silent> <Leader>ta :call neoterm#test#run('all')<cr>
" nnoremap <silent> <Leader>tf :call neoterm#test#run('file')<cr>
" nnoremap <silent> <Leader>tc :call neoterm#test#run('current')<cr>
" nnoremap <silent> <Leader>tr :call neoterm#test#rerun()<cr>
nnoremap <silent> <Leader>to :call neoterm#open()<cr>
nnoremap <silent> <Leader>tx :call neoterm#close()<cr>
nnoremap <silent> <Leader>tc :call neoterm#clear()<cr>

nnoremap <silent> <Leader>tl :TREPLSendLine<cr>

" kills the current job (send a <c-c>)
nnoremap <silent> <Leader>tx :call neoterm#kill()<cr>
