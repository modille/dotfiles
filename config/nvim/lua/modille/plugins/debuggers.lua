return {
  'mfussenegger/nvim-dap',

  dependencies = {

    -- fancy UI for the debugger
    {
      'rcarriga/nvim-dap-ui',
      -- stylua: ignore
      keys = {
        { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
      },
      opts = {},
      config = function(_, opts)
        local dap = require('dap')
        local dapui = require('dapui')
        dapui.setup(opts)
        dap.listeners.after.event_initialized['dapui_config'] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated['dapui_config'] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
          dapui.close({})
        end
      end,
    },

    -- virtual text for the debugger
    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {},
    },

    -- mason.nvim integration
    {
      'jay-babu/mason-nvim-dap.nvim',
      dependencies = 'mason.nvim',
      cmd = { 'DapInstall', 'DapUninstall' },
      opts = {
        -- Makes a best effort to setup the various debuggers with
        -- reasonable debug configurations
        automatic_installation = true,

        -- You can provide additional configuration to the handlers,
        -- see mason-nvim-dap README for more information
        handlers = {},

        -- You'll need to check that you have the required things installed
        -- online, please don't ask me how to install them :)
        ensure_installed = {
          -- Update this to ensure that you have the debuggers for the langs you want
        },
      },
    },

    -- javascript
    {
      'mxsdev/nvim-dap-vscode-js',
      config = function()
        require('dap-vscode-js').setup({
          debugger_path = os.getenv('HOME') .. '/git/github.com/microsoft/vscode-js-debug',
          adapters = { 'pwa-node' },
        })
        require('dap').configurations['javascript'] = {
          {
            name = 'Launch Jest',
            type = 'pwa-node',
            request = 'launch',
            trace = true,
            runtimeArgs = {
              '${workspaceRoot}/node_modules/jest/bin/jest.js',
            },
            console = 'integratedTerminal',
            internalConsoleOptions = 'neverOpen',
          },
          {
            name = 'Attach to debugger',
            type = 'pwa-node',
            request = 'attach',
            cwd = '${workspaceFolder}',
          },
        }
        require('dap').configurations['cucumber'] = {
          {
            name = 'Attach to debugger',
            type = 'pwa-node',
            request = 'attach',
            cwd = '${workspaceFolder}',
          },
        }
      end,
    },

    -- ruby
    {
      'suketa/nvim-dap-ruby',
      config = function()
        require('dap-ruby').setup()
      end,
    },
  },

  keys = {
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))
      end,
      desc = 'Breakpoint Condition',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Toggle Breakpoint',
    },
    {
      '<leader>dc',
      function()
        require('dap').continue()
      end,
      desc = 'Continue',
    },
    {
      '<leader>dC',
      function()
        require('dap').run_to_cursor()
      end,
      desc = 'Run to Cursor',
    },
    {
      '<leader>dg',
      function()
        require('dap').goto_()
      end,
      desc = 'Go to line (no execute)',
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = 'Step Into',
    },
    {
      '<leader>dj',
      function()
        require('dap').down()
      end,
      desc = 'Down',
    },
    {
      '<leader>dk',
      function()
        require('dap').up()
      end,
      desc = 'Up',
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = 'Run Last',
    },
    {
      '<leader>do',
      function()
        require('dap').step_out()
      end,
      desc = 'Step Out',
    },
    {
      '<leader>dO',
      function()
        require('dap').step_over()
      end,
      desc = 'Step Over',
    },
    {
      '<leader>dp',
      function()
        require('dap').pause()
      end,
      desc = 'Pause',
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.toggle()
      end,
      desc = 'Toggle REPL',
    },
    {
      '<leader>ds',
      function()
        require('dap').session()
      end,
      desc = 'Session',
    },
    {
      '<leader>dt',
      function()
        require('dap').terminate()
      end,
      desc = 'Terminate',
    },
    {
      '<leader>dw',
      function()
        require('dap.ui.widgets').hover()
      end,
      desc = 'Widgets',
    },
  },

  config = function()
    vim.api.nvim_set_hl(0, 'DapStoppedLine', { default = true, link = 'Visual' })

    local Config = {
      icons = {
        dap = {
          Stopped = { '󰁕 ', 'DiagnosticWarn', 'DapStoppedLine' },
          Breakpoint = ' ',
          BreakpointCondition = ' ',
          BreakpointRejected = { ' ', 'DiagnosticError' },
          LogPoint = '.>',
        },
      },
    }
    for name, sign in pairs(Config.icons.dap) do
      sign = type(sign) == 'table' and sign or { sign }
      vim.fn.sign_define(
        'Dap' .. name,
        { text = sign[1], texthl = sign[2] or 'DiagnosticInfo', linehl = sign[3], numhl = sign[3] }
      )
    end
  end,
}
