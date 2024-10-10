return {
  {
    "vim-test/vim-test",
    enabled = true,
    dependencies = { "voldikss/vim-floaterm" },
    init = function()
      vim.g["test#strategy"] = "neovim" -- 'floaterm' -- 'neovim'
      vim.cmd([[
      let test#ruby#use_binstubs = 1
      let test#ruby#bundle_exec = 1
      let test#ruby#rspec#options = '--format documentation'

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
        let g:test#javascript#cucumberjs#executable = './node_modules/.bin/cucumber-js'
        let $RECORD = "true"
        TestNearest
        unlet $RECORD
        unlet g:test#javascript#cucumberjs#executable
      endfunction

      function! CucumberDebugRecordNearest()
        let g:test#javascript#cucumberjs#executable = 'node --inspect-brk node_modules/.bin/cucumber-js'
        let $RECORD = "true"
        TestNearest
        unlet $RECORD
        unlet g:test#javascript#cucumberjs#executable
      endfunction

      function! CucumberDebugNearest()
        let g:test#javascript#cucumberjs#executable = 'node --inspect-brk node_modules/.bin/cucumber-js'
        TestNearest
        unlet g:test#javascript#cucumberjs#executable
      endfunction
      ]])
    end,
    keys = {
      { "<leader>Tn", "<cmd>TestNearest<cr>", desc = "Test nearest" },
      { "<leader>Tf", "<cmd>TestFile<cr>", desc = "Test file" },
      { "<leader>Tl", "<cmd>TestLast<cr>", desc = "Test last" },
      { "<leader>Ts", "<cmd>TestSuite<cr>", desc = "Test suite" },
      { "<leader>Tg", "<cmd>TestVisit<cr>", desc = "Test visit" },
    },
  },
}
