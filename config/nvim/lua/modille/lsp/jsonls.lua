-- https://github.com/neovim/nvim-lspconfig
local lspconfig = require('lspconfig')

-- https://github.com/hrsh7th/nvim-cmp
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#jsonls
lspconfig.jsonls.setup({
  capabilities = capabilities,
  settings = {
    json = {
      -- https://github.com/b0o/schemastore.nvim#usage
      schemas = require('schemastore').json.schemas(),
    },
  },
})
