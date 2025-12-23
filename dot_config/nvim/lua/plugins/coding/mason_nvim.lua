---@type LazySpec
return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "docker-compose-language-service",
        "dockerfile-language-server",
        "eslint-lsp",
        "fish-lsp",
        "herb-language-server",
        "html-lsp",
        "java-debug-adapter",
        "java-test",
        "jdtls",
        "js-debug-adapter",
        "json-lsp",
        "kotlin-debug-adapter",
        "kotlin-language-server",
        "lemminx",
        "lua-language-server",
        "markdownlint",
        "marksman",
        "prettier",
        "prettierd",
        "shellcheck",
        "shfmt",
        "sonarlint-language-server",
        "stylua",
        "tailwindcss-language-server",
        "terraform-ls",
        "typescript-language-server",
        "yaml-language-server",
      })
      local function remove_item(t, item)
        for i, v in ipairs(t) do
          if v == item then
            table.remove(t, i)
            break
          end
        end
      end
      remove_item(opts.ensure_installed, "hadolint") -- not working with nvim-lint
    end,
  },
}
