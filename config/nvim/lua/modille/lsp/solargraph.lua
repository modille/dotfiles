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
      formatting = true,
      folding = true,
      checkGemVersion = false,
      useBundler = true,
      -- bundlePath = '/var/folders/xk/lm_549095ml5lvk1bkl3vc000000gp/T/frum_1103_1690382810047/bin/bundle',
    },
  },
  on_attach = function(client, bufnr)
    -- Format on save
    -- if client.server_capabilities.documentFormattingProvider then
    vim.cmd([[
      augroup ModilleSolargraphFormatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
      augroup END
    ]])
    -- end

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
  end,
})
