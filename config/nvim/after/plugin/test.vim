nnoremap <silent> <Leader>tn :TestNearest<CR>
nnoremap <silent> <Leader>tf :TestFile<CR>
nnoremap <silent> <Leader>ts :TestSuite<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>
nnoremap <silent> <Leader>tg :TestVisit<CR>

" Test
" Make test commands execute using dispatch.vim
let g:test#strategy = 'neovim'

function! JestDebugNearest()
  let g:test#javascript#runner = 'jest'
  let g:test#javascript#jest#executable = 'node --inspect-brk node_modules/jest/bin/jest.js --runInBand'
  TestNearest
  unlet g:test#javascript#runner
  unlet g:test#javascript#jest#executable
endfunction

function! CucumberRecordNearest()
  let g:test#javascript#runner = 'cucumberjs'
  let g:test#javascript#cucumberjs#executable = './node_modules/.bin/cucumber-js'
  let $RECORD = "true"
  TestNearest
  unlet $RECORD
  unlet g:test#javascript#runner
  unlet g:test#javascript#cucumberjs#executable
endfunction

function! CucumberDebugRecordNearest()
  let g:test#javascript#runner = 'cucumberjs'
  let g:test#javascript#cucumberjs#executable = './node_modules/.bin/ndb node_modules/.bin/cucumber.js'
  let $RECORD = "true"
  TestNearest
  unlet $RECORD
  unlet g:test#javascript#runner
  unlet g:test#javascript#cucumberjs#executable
endfunction

function! CucumberDebugNearest()
  let g:test#javascript#runner = 'cucumberjs'
  let g:test#javascript#cucumberjs#executable = './node_modules/.bin/ndb node_modules/.bin/cucumber.js'
  TestNearest
  unlet g:test#javascript#runner
  unlet g:test#javascript#cucumberjs#executable
endfunction
