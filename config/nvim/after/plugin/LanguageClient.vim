" let g:LanguageClient_autoStop = 0
" let g:LanguageClient_serverCommands = {
"   \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio']
"   \ }

" nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" autocmd FileType ruby setlocal omnifunc=LanguageClient#complete
