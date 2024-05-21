return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "docker-compose-language-service",
        "dockerfile-language-server",
        "eslint-lsp",
        "hadolint",
        "java-debug-adapter",
        "java-test",
        "jdtls",
        "js-debug-adapter",
        "json-lsp",
        "kotlin-debug-adapter",
        "kotlin-language-server",
        "lua-language-server",
        "markdownlint",
        "marksman",
        "prettier",
        "prettierd",
        "shellcheck",
        "shfmt",
        "stylua",
        "terraform-ls",
        "typescript-language-server",
        "yaml-language-server",
      })
    end,
  },
}
