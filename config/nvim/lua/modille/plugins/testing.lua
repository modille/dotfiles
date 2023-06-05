return {
  {
    'vim-test/vim-test',
    dependencies = { 'voldikss/vim-floaterm' },
    init = function()
      vim.g['test#strategy'] = 'floaterm'
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
      ]])
    end,
    keys = {
      { '<leader>tn', '<cmd>TestNearest<cr>', desc = 'Test nearest' },
      { '<leader>tf', '<cmd>TestFile<cr>',    desc = 'Test file' },
      { '<leader>tl', '<cmd>TestLast<cr>',    desc = 'Test last' },
      { '<leader>ts', '<cmd>TestSuite<cr>',   desc = 'Test suite' },
      { '<leader>ts', '<cmd>TestVisit<cr>',   desc = 'Test visit' },
    },
  },
  {
    'nvim-neotest/neotest',
    enabled = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'haydenmeade/neotest-jest',
      'olimorris/neotest-rspec',
    },
    opts = function()
      local neotest_jest_adapter = require('neotest-jest')({
        jestCommand = 'npm test --',
        -- jestConfigFile = "custom.jest.config.ts",
        env = { CI = true },
        cwd = function(path)
          return vim.fn.getcwd()
        end,
      })
      neotest_jest_adapter.filter_dir = function(name)
        return name ~= 'node_modules' and name ~= '__snapshots__'
      end
      return {
        adapters = {
          neotest_jest_adapter,
          require('neotest-rspec'),
        },
        status = {
          enabled = true,
          signs = true,
          virtual_text = true,
        },
      }
    end,
    keys = {
      { '<leader>tn',  "<cmd>lua require('neotest').run.run()<cr>",                     desc = 'Test nearest' },
      { '<leader>tf',  "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",   desc = 'Test file' },
      { '<leader>tl',  "<cmd>lua require('neotest').run.run_last()<cr>",                desc = 'Test last' },
      { '<leader>ts',  "<cmd>lua require('neotest').run.run(vim.fn.getcwd())<cr>",      desc = 'Test suite' },
      { '<leader>tdn', "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<cr>", desc = 'Test debug nearest' },
      {
        '<leader>tdf',
        "<cmd>lua require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' })<cr>",
        desc = 'Test debug file',
      },
      { '<leader>tdl', "<cmd>lua require('neotest').run.run_last({ strategy = 'dap' })<cr>", desc = 'Test debug last' },
      {
        '<leader>tds',
        "<cmd>lua require('neotest').run.run({ vim.fn.getcwd(), strategy = 'dap' })<cr>",
        desc = 'Test debug suite',
      },
      {
        '<leader>twj',
        "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
        desc = 'Test watch jest',
      },
    },
  },
}
