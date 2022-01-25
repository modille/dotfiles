-- https://github.com/kosayoda/nvim-lightbulb
vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])

-- https://github.com/folke/trouble.nvim
require('trouble').setup({})

-- https://github.com/neovim/nvim-lspconfig
local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}
-- https://github.com/hrsh7th/nvim-cmp
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
lspconfig.bashls.setup({ flags = { debounce_text_changes = 150 } })

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dockerls
lspconfig.dockerls.setup({ flags = { debounce_text_changes = 150 } })

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
lspconfig.pylsp.setup({ flags = { debounce_text_changes = 150 } })

require('modille.lsp.jsonls')
require('modille.lsp.null-ls')
require('modille.lsp.solargraph')
require('modille.lsp.tsserver')
