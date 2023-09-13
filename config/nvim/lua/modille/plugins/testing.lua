return {
  {
    'vim-test/vim-test',
    enabled = true,
    dependencies = { 'voldikss/vim-floaterm' },
    init = function()
      vim.g['test#strategy'] = 'neovim' -- 'floaterm' -- 'neovim'
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
    -- keys = {
    --   { '<leader>tn', '<cmd>TestNearest<cr>', desc = 'Test nearest' },
    --   { '<leader>tf', '<cmd>TestFile<cr>',    desc = 'Test file' },
    --   { '<leader>tl', '<cmd>TestLast<cr>',    desc = 'Test last' },
    --   { '<leader>ts', '<cmd>TestSuite<cr>',   desc = 'Test suite' },
    --   { '<leader>ts', '<cmd>TestVisit<cr>',   desc = 'Test visit' },
    -- },
  },
  {
    'nvim-neotest/neotest',
    enabled = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'antoinemadec/FixCursorHold.nvim',
      'haydenmeade/neotest-jest',
      'olimorris/neotest-rspec',
      'vim-test/vim-test',
      'nvim-neotest/neotest-vim-test',
    },
    opts = function()
      local neotest_jest_adapter = require('neotest-jest')({
        jestCommand = 'npm test --',
        -- needed for dap?:
        -- env = { CI = true },
        -- cwd = function(path)
        --   return vim.fn.getcwd()
        -- end,
      })
      neotest_jest_adapter.filter_dir = function(name)
        return name ~= 'node_modules' and name ~= '__snapshots__'
      end
      return {
        log_level = 1,
        adapters = {
          neotest_jest_adapter,
          require('neotest-rspec'),
          require('neotest-vim-test')({
            allow_file_types = { 'cucumber' },
          }),
        },
        highlights = {
          adapter_name = 'NeotestAdapterName',
          border = 'NeotestBorder',
          dir = 'NeotestDir',
          expand_marker = 'NeotestExpandMarker',
          failed = 'Error',
          file = 'NeotestFile',
          focused = 'NeotestFocused',
          indent = 'NeotestIndent',
          marked = 'NeotestMarked',
          namespace = 'NeotestNamespace',
          passed = 'NeotestPassed',
          running = 'NeotestRunning',
          select_win = 'NeotestWinSelect',
          skipped = 'NeotestSkipped',
          target = 'NeotestTarget',
          test = 'NeotestTest',
          unknown = 'NeotestUnknown',
          watching = 'NeotestWatching',
        },
        status = {
          enabled = true,
          signs = false,
          virtual_text = true,
        },
      }
    end,
    config = function(_, opts)
      local neotest_ns = vim.api.nvim_create_namespace('neotest')
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
            return message
          end,
        },
      }, neotest_ns)

      require('neotest').setup(opts)
    end,
    keys = {
      {
        '<leader>tn',
        function()
          require('neotest').run.run()
        end,
        desc = 'Test nearest',
      },
      {
        '<leader>tf',
        function()
          require('neotest').run.run(vim.fn.expand('%'))
        end,
        desc = 'Test file',
      },
      {
        '<leader>tl',
        function()
          require('neotest').run.run_last()
        end,
        desc = 'Test last',
      },
      {
        '<leader>ts',
        function()
          require('neotest').run.run({ suite = true })
        end,
        desc = 'Test suite',
      },
      {
        '<leader>tdn',
        function()
          require('neotest').run.run({ strategy = 'dap' })
        end,
        desc = 'Test debug nearest',
      },
      {
        '<leader>tdf',
        function()
          require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' })
        end,
        desc = 'Test debug file',
      },
      {
        '<leader>tdl',
        function()
          require('neotest').run.run_last({ strategy = 'dap' })
        end,
        desc = 'Test debug last',
      },
      {
        '<leader>tds',
        function()
          require('neotest').run.run({ suite = true, strategy = 'dap' })
        end,
        desc = 'Test debug suite',
      },
      {
        '<leader>twj',
        function()
          require('neotest').run.run({ jestCommand = 'jest --watch ' })
        end,
        desc = 'Test watch jest',
      },
      {
        '<leader>to',
        function()
          require('neotest').output.open({ enter = true })
        end,
        desc = 'Test output',
      },
    },
  },
}
