nnoremap <silent> <Leader>tn :TestNearest<CR>
nnoremap <silent> <Leader>tf :TestFile<CR>
nnoremap <silent> <Leader>ts :TestSuite<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>
nnoremap <silent> <Leader>tg :TestVisit<CR>

" Test
" Make test commands execute using dispatch.vim
let g:test#strategy = 'neovim'

function! DebugNearest()
  let g:test#javascript#runner = 'jest'
  let g:test#javascript#jest#executable = './node_modules/.bin/ndb node_modules/jest/bin/jest.js --runInBand'
  TestNearest
  unlet g:test#javascript#runner
  unlet g:test#javascript#jest#executable
endfunction
nmap <silent> <Leader>td :call DebugNearest()<CR>
