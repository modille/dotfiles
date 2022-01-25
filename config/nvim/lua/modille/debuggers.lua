-- https://github.com/theHamsta/nvim-dap-virtual-text
require('nvim-dap-virtual-text').setup({
  -- use a comment-like syntax to further improve distinguishability between actual code and debugger info
  commented = true,
})

-- https://github.com/mfussenegger/nvim-dap
local dap = require('dap')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/git/github.com/microsoft/vscode-node-debug2/out/src/nodeDebug.js' },
}

vim.fn.sign_define('DapBreakpoint', { text = '⏸ ', texthl = '', linehl = '', numhl = '' })

-- https://github.com/rcarriga/nvim-dap-ui
require('dapui').setup({
  sidebar = {
    elements = {},
  },
  tray = {
    elements = { 'repl' },
    size = 15,
    position = 'bottom',
  },
})
