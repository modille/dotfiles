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

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#borders
-- Override vim.lsp.util.open_floating_preview to set border globally.
local border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bashls
lspconfig.bashls.setup({ flags = { debounce_text_changes = 150 } })

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dockerls
lspconfig.dockerls.setup({ flags = { debounce_text_changes = 150 } })

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#lua_ls
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        checkThirdParty = false,
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pylsp
lspconfig.pylsp.setup({ flags = { debounce_text_changes = 150 } })

require('modille.lsp.cucumber_language_server')
require('modille.lsp.jsonls')
-- require('modille.lsp.ruby-lsp')
require('modille.lsp.solargraph')
require('modille.lsp.tsserver')
