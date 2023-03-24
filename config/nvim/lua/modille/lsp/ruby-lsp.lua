require('lspconfig').ruby_ls.setup({
  cmd = { 'ruby-lsp' },
  filetypes = { 'ruby' },
  init_options = { formatting = true },
  {
    enabledFeatures = {
      'codeActions',
      'diagnostics',
      'documentHighlights',
      'documentSymbols',
      -- 'formatting', -- use solargraph instead. to use ruby-lsp for formatting requires being installed in Gemfile
      'inlayHint',
    },
  },
})
