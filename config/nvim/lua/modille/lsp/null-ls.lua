-- https://github.com/jose-elias-alvarez/null-ls.nvim
local augroup = vim.api.nvim_create_augroup('ModilleNullLsFormatting', {})
local null_ls = require('null-ls')
null_ls.setup({
  sources = {
    -- eslint_d
    null_ls.builtins.formatting.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.code_actions.eslint_d,
    -- hadolint
    null_ls.builtins.diagnostics.hadolint,
    -- prettier
    null_ls.builtins.formatting.prettier.with({
      filetypes = { 'markdown' },
    }),
    -- refactoring.nvim
    null_ls.builtins.code_actions.refactoring,
    -- shellcheck
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.code_actions.shellcheck,
    -- stylua
    null_ls.builtins.formatting.stylua,
    -- vale
    -- null_ls.builtins.diagnostics.vale.with({
    --   filetypes = { 'markdown', 'gitcommit_markdown', 'javascript', 'ruby' },
    -- }),
  },
  should_attach = function(bufnr)
    return not vim.api.nvim_buf_get_name(bufnr):match('.env')
  end,
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end

    -- Fix null-ls + markdown + gq
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_buf_set_option(bufnr, 'formatexpr', '')
    end
  end,
})
