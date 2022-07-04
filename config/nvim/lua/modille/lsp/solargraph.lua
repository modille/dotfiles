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

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#solargraph
lspconfig.solargraph.setup({
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = { 'bundle', 'exec', 'solargraph', 'stdio' },
  filetypes = { 'ruby' },
  init_options = { formatting = true },
  root_dir = lspconfig.util.root_pattern('Gemfile', '.git'),
  settings = {
    solargraph = {
      diagnostics = true,
    },
  },
  on_attach = function(client, bufnr)
    -- Format on save
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd([[
      augroup ModilleSolargraphFormatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
      augroup END
      ]])
    end

    -- https://github.com/stevearc/aerial.nvim
    require('aerial').on_attach(client, bufnr)

    -- Options
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Keymaps
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local opts = { noremap = true, silent = true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  end,
})
