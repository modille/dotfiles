nnoremap <silent> <Leader>jc :JavaCorrect<CR>
nnoremap <silent> <Leader>jio :JavaImportOrganize<CR>

nnoremap <silent> <Leader>jn :JavaNew<space>
nnoremap <silent> <Leader>jr :JavaRename<space>
nnoremap <silent> <Leader>jsa :JavaSearch -a edit -x all<CR>
nnoremap <silent> <Leader>jsc :JavaSearchContext<CR>
nnoremap <silent> <Leader>jsd :JavaSearch -a edit -x declarations<CR>
nnoremap <silent> <Leader>jsi :JavaSearch -a edit -x implementors<CR>
nnoremap <silent> <Leader>jsr :JavaSearch -a edit -x references<CR>

" Mnemonic = context, file, integration, unit
" nnoremap <silent> <Leader>juc :JUnit<CR>
" nnoremap <silent> <Leader>juf :JUnit %<CR>
nnoremap <silent> <Leader>jui :Dispatch gradle integrationTest jacocoTestReport<CR>
nnoremap <silent> <Leader>juu :Dispatch gradle test jacocoTestReport<CR>

nnoremap <silent> <Leader>msa :make spotlessApply<CR>

let g:EclimJavaSearchSingleResult = 'edit'
