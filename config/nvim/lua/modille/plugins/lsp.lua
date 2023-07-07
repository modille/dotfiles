return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'stevearc/aerial.nvim',
        opts = {
          backends = { 'lsp', 'treesitter', 'markdown' }, -- in priority order
          filter_kind = false,
        },
        keys = {
          { '<leader>a', '<cmd>AerialToggle!<CR>' },
        },
      },
      'b0o/schemastore.nvim',
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      {
        'folke/neodev.nvim',
        opts = {
          library = { plugins = { 'neotest' }, types = true },
        },
      },
      'hrsh7th/cmp-nvim-lsp',
      'folke/trouble.nvim',
      {
        'j-hui/fidget.nvim',
        opts = {
          sources = {
            ['null-ls'] = {
              ignore = true,
            },
          },
        },
      },
      {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function()
          require('lsp_lines').setup()
          vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
        end,
        keys = {
          {
            '<leader>l',
            function()
              if vim.diagnostic.config().virtual_lines then
                vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
              else
                vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
              end
            end,
            desc = 'Toggle lsp_lines',
          },
        },
      },
    },
    config = function()
      require('modille.lsp')
    end,
  },

  {
    'jose-elias-alvarez/null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = function()
      local augroup = vim.api.nvim_create_augroup('ModilleNullLsFormatting', {})
      local null_ls = require('null-ls')
      return {
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
      }
    end,
  },

  {
    'kosayoda/nvim-lightbulb', -- Show gutter sign when action is available
    dependencies = 'antoinemadec/FixCursorHold.nvim',
    config = function()
      vim.cmd(
        [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb({ ignore = {"null-ls"} })]]
      )
    end,
  },
}
