nnoremap <silent> <Leader>tn :TestNearest<CR>
nnoremap <silent> <Leader>tf :TestFile<CR>
nnoremap <silent> <Leader>ts :TestSuite<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>
nnoremap <silent> <Leader>tg :TestVisit<CR>

" Runs test commands with :terminal in a split window.
let g:test#strategy = 'neovim'

" Run tests in a full-height vertical right split in order to see more output
let test#neovim#term_position = 'vert botright'

function! JestDebugNearest()
  let g:test#javascript#runner = 'jest'
  let g:test#javascript#jest#executable = 'node --inspect-brk node_modules/jest/bin/jest.js --runInBand'
  TestNearest
  unlet g:test#javascript#runner
  unlet g:test#javascript#jest#executable
endfunction

function! JestNearestFeature()
  let g:test#javascript#runner = 'jest'
  let g:test#javascript#jest#executable = './node_modules/jest/bin/jest.js --runInBand --config=jest.config.features.js'
  TestNearest
  unlet g:test#javascript#runner
  unlet g:test#javascript#jest#executable
endfunction

function! JestDebugNearestFeature()
  let g:test#javascript#runner = 'jest'
  let g:test#javascript#jest#executable = 'node --inspect-brk node_modules/jest/bin/jest.js --runInBand --config=jest.config.features.js'
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
