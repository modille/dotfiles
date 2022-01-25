-- https://github.com/jose-elias-alvarez/null-ls.nvim
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
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
      augroup ModilleNullLsFormatting
      autocmd! * <buffer>
      autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
      ]])
    end
  end,
})
