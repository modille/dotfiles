return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
      },
      servers = {
        bashls = {},
        solargraph = {
          flags = {
            debounce_text_changes = 150,
          },

          -- Install via Gemfile rather than Mason
          mason = false,
          cmd = { "bundle", "exec", "solargraph", "stdio" },

          init_options = { formatting = true },
          settings = {
            solargraph = {
              diagnostics = true,
              formatting = true,
              folding = true,
              checkGemVersion = false,
              useBundler = true,
            },
          },
          on_attach = function()
            -- Format on save
            vim.cmd([[
              augroup ModilleSolargraphFormatting
              autocmd! * <buffer>
              autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
              augroup END
            ]])
          end,
        },
        tsserver = {
          settings = {
            diagnostics = {
              ignoredCodes = {
                7016, -- Allow untyped modules
                80001, -- Allow CommonJS modules
              },
            },
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
      },
    },
  },
}
