nnoremap <silent> <Leader>jc :JavaCorrect<CR>
nnoremap <silent> <Leader>jio :JavaImportOrganize<CR>

nnoremap <silent> <Leader>jn :JavaNew<space>
nnoremap <silent> <Leader>jr :JavaRename<space>
nnoremap <silent> <Leader>js :JavaSearch<space>

" Mnemonic = context, file, integration, unit
" nnoremap <silent> <Leader>juc :JUnit<CR>
" nnoremap <silent> <Leader>juf :JUnit %<CR>
nnoremap <silent> <Leader>jui :Dispatch gradle integrationTest jacocoTestReport<CR>
nnoremap <silent> <Leader>juu :Dispatch gradle test jacocoTestReport<CR>

nnoremap <silent> <Leader>msa :make spotlessApply<CR>

let g:EclimJavaSearchSingleResult = 'edit'
