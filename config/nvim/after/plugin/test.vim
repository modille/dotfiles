" nnoremap <silent> <Leader>tn :TestNearest<CR>
" nnoremap <silent> <Leader>tf :TestFile<CR>
" nnoremap <silent> <Leader>ts :TestSuite<CR>
" nnoremap <silent> <Leader>tl :TestLast<CR>
" nnoremap <silent> <Leader>tg :TestVisit<CR>

" Make test commands execute using dispatch.vim
let g:test#strategy = 'dispatch'

" Automatically run tests when a test file or its alternate application file is saved
" augroup test
"   autocmd!
"   autocmd BufWrite * if test#exists() |
"     \   TestFile
"     \ endif
" augroup END
