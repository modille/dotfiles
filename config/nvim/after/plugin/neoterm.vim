let g:neoterm_rspec_lib_cmd = 'rspec --color --format doc'

" Allow sending command directly to shell
let g:neoterm_auto_repl_cmd = 0

" nnoremap <silent> <Leader>ta :call neoterm#test#run('all')<cr>
" nnoremap <silent> <Leader>tf :call neoterm#test#run('file')<cr>
" nnoremap <silent> <Leader>tc :call neoterm#test#run('current')<cr>
" nnoremap <silent> <Leader>tr :call neoterm#test#rerun()<cr>
nnoremap <silent> <Leader>to :call neoterm#open()<cr>
nnoremap <silent> <Leader>tx :call neoterm#close()<cr>
nnoremap <silent> <Leader>tc :call neoterm#clear()<cr>

nnoremap <silent> <Leader>tr :TREPLSendLine<cr>

" kills the current job (send a <c-c>)
nnoremap <silent> <Leader>tx :call neoterm#kill()<cr>
