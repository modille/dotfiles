-- https://github.com/theHamsta/nvim-dap-virtual-text
vim.g.dap_virtual_text = true

-- https://github.com/mfussenegger/nvim-dap
local dap = require('dap')
dap.set_log_level('TRACE')

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { os.getenv('HOME') .. '/git/github.com/microsoft/vscode-node-debug2/out/src/nodeDebug.js' },
}
dap.configurations.javascript = {
  {
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    cmd = "node_modules/.bin/jest -t '$result' -- $file",
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.js'},
    console = 'integratedTerminal',
    port = 9229,
  },
}

-- https://github.com/rcarriga/nvim-dap-ui
require('dapui').setup()
