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

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#tsserver
lspconfig.tsserver.setup({
  capabilities = capabilities,

  flags = {
    debounce_text_changes = 150,
  },

  -- https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils#setup
  init_options = require('nvim-lsp-ts-utils').init_options,

  on_attach = function(client, bufnr)
    local ts_utils = require('nvim-lsp-ts-utils')
    ts_utils.setup({
      debug = false,
      disable_commands = false,
      enable_import_on_completion = true,
      import_all_timeout = 5000, -- ms
      import_all_priorities = {
        same_file = 1,
        local_files = 2,
        buffer_content = 3,
        buffers = 4,
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,
      filter_out_diagnostics_by_severity = {},
      filter_out_diagnostics_by_code = {
        -- Allow untyped modules
        7016,
        -- Allow CommonJs modules
        80001,
      },
      auto_inlay_hints = false,
      inlay_hints_highlight = 'Comment',
      update_imports_on_move = true,
      require_confirmation_on_move = true,
      watch_dir = true,
    })
    ts_utils.setup_client(client)

    -- Don't use tsserver for formatting, we'll use null-ls + eslint_d instead
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

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

    -- https://github.com/neovim/nvim-lspconfig#suggested-configuration
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

    -- https://github.com/neovim/nvim-lspconfig#suggested-configuration
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    -- https://github.com/jose-elias-alvarez/nvim-lsp-ts-utils
    buf_set_keymap('n', 'gs', ':TSLspOrganize<CR>', opts)
    -- buf_set_keymap('n', 'gr', ':TSLspRenameFile<CR>', opts)
    -- buf_set_keymap('n', 'gi', ':TSLspImportAll<CR>', opts)
  end,
})
