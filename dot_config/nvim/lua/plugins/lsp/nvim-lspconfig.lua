return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = {
        enabled = true,
      },
      codelens = {
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
        fish_lsp = {
          cmd = { "/opt/homebrew/bin/fish-lsp", "start" },
        },
        dockerls = {},
        docker_compose_language_service = {},
        herb_ls = {
          settings = {
            languageServerHerb = {
              formatter = { enabled = true },
            },
          },
        },
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
        ruby_lsp = {
          -- https://shopify.github.io/ruby-lsp/editors#lazyvim-lsp
          mason = false,
          cmd = { "ruby-lsp" },
          filetypes = { "ruby" }, -- exclude "eruby", use herb for that instead
          -- https://epona.me/blog/implementing-vs-code-like-ruby-lsp-features-in-neovim/#adding-ruby-lsp-configuration
          on_attach = function(client, bufnr)
            client.commands = client.commands or {}

            client.commands["rubyLsp.openFile"] = function(command)
              local file_path = command.arguments[1][1]

              local path, line = string.match(file_path, "(.+)#L(%d+)")
              path = path or file_path -- if no line number, use the whole path

              path = string.gsub(path, "file://", "")
              vim.cmd("edit " .. path)

              if line then
                vim.cmd(line)
              end
            end
          end,
        },
        tailwindcss = {},
        ts_ls = {
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
