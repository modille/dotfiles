return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
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
        "ktlint", -- :MasonUninstall ktlint and :MasonInstall ktlint@0.49.1 to install specific version
        "lua-language-server",
        "markdownlint",
        "marksman",
        "prettier",
        "prettierd",
        "shellcheck",
        "shfmt",
        "solargraph",
        "stylua",
        "terraform-ls",
        "typescript-language-server",
        "yaml-language-server",
      },
    },
  },
}
