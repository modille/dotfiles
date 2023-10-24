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
        tag = 'legacy',
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
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' }, -- can use LazyFile in v10
    dependencies = { 'mason.nvim' },
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
          -- rubocop
          -- null_ls.builtins.diagnostics.rubocop,
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
    opts = {
      autocmd = { enabled = true },
      ignore = {
        clients = { 'null-ls' },
      },
    },
  },

  {
    'lvimuser/lsp-inlayhints.nvim',
    branch = 'anticonceal',
    lazy = false,
    keys = {
      { '<leader>il', "<cmd>lua require('lsp-inlayhints').toggle()<CR>" },
    },
  },

  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    opts = {
      ensure_installed = {
        'dockerfile-language-server',
        -- 'eslint-lsp',
        'eslint_d',
        'hadolint',
        'js-debug-adapter',
        'nginx-language-server',
        'shellcheck',
        'sonarlint-language-server',
        'stylua',
        'typescript-language-server',
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
}
