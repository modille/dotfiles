return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
      },
      servers = {
        basedpyright = {
          cmd = { "poetry", "run", "basedpyright-langserver", "--stdio" },
          settings = {
            basedpyright = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = true,
                -- customizations below:
                typeCheckingMode = "off",
              },
            },
          },
        },
        bashls = {},
        dockerls = {},
        docker_compose_language_service = {},
        html = {
          init_options = {
            configurationSection = { "html", "css", "javascript" },
            embeddedLanguages = {
              css = true,
              javascript = true,
            },
            provideFormatter = false, -- disable; use prettier for formatting instead
          },
        },
        kotlin_language_server = {},
        lemminx = {},
        -- solargraph = {
        --   flags = {
        --     debounce_text_changes = 150,
        --   },

        --   -- Install via Gemfile rather than Mason
        --   mason = false,
        --   -- cmd = { "bundle", "exec", "solargraph", "stdio" },
        --   cmd = { "solargraph", "stdio" },

        --   init_options = { formatting = true },
        --   settings = {
        --     solargraph = {
        --       diagnostics = true,
        --       formatting = true,
        --       folding = true,
        --       checkGemVersion = false,
        --       useBundler = true,
        --     },
        --   },
        --   on_attach = function()
        --     -- Format on save
        --     vim.cmd([[
        --       augroup ModilleSolargraphFormatting
        --       autocmd! * <buffer>
        --       autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
        --       augroup END
        --     ]])
        --   end,
        -- },
        rubocop = {
          mason = false,
          cmd = { vim.fn.expand("~/.asdf/shims/rubocop"), "--lsp" },
        },
        ruby_lsp = {
          mason = false,
          -- cmd = { vim.fn.expand("~/.local/share/mise/installs/ruby/3.3.4/bin/ruby-lsp") },
          cmd = { vim.fn.expand("~/.asdf/shims/ruby-lsp") },
          init_options = {
            enabledFeatures = {
              codeActions = true,
              codeLens = true,
              completion = true,
              definition = true,
              diagnostics = true,
              documentHighlights = true,
              documentLink = true,
              documentSymbols = true,
              foldingRanges = true,
              formatting = true,
              hover = true,
              inlayHint = true,
              onTypeFormatting = true,
              selectionRanges = true,
              semanticHighlighting = true,
              signatureHelp = true,
              typeHierarchy = true,
              workspaceSymbol = true,
            },
          },
        },
        sorbet = {
          mason = false,
          cmd = { "bundle", "exec", "srb", "tc", "--lsp" },
          init_options = {
            highlightUntyped = true,
          },
        },
        tailwindcss = {},
        -- ts_ls = {
        --   settings = {
        --     diagnostics = {
        --       ignoredCodes = {
        --         7016, -- Allow untyped modules
        --         80001, -- Allow CommonJS modules
        --       },
        --     },
        --     typescript = {
        --       inlayHints = {
        --         includeInlayParameterNameHints = "all",
        --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --         includeInlayFunctionParameterTypeHints = true,
        --         includeInlayVariableTypeHints = true,
        --         includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        --         includeInlayPropertyDeclarationTypeHints = true,
        --         includeInlayFunctionLikeReturnTypeHints = true,
        --         includeInlayEnumMemberValueHints = true,
        --       },
        --     },
        --     javascript = {
        --       inlayHints = {
        --         includeInlayParameterNameHints = "all",
        --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --         includeInlayFunctionParameterTypeHints = true,
        --         includeInlayVariableTypeHints = true,
        --         includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        --         includeInlayPropertyDeclarationTypeHints = true,
        --         includeInlayFunctionLikeReturnTypeHints = true,
        --         includeInlayEnumMemberValueHints = true,
        --       },
        --     },
        --   },
        -- },
        vtsls = {
          ["js/ts"] = {
            implicitProjectConfig = {
              module = "CommonJS", -- TODO trying to ignore ts 80001 "File is a CommonJS module; it may be converted to an ES module" without renaming to .cjs
            },
          },
        },
      },
    },
  },
}
