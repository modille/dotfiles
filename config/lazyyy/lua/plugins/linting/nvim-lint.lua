return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        sh = { "shellcheck" },
      },
      linters = {
        markdownlint = {
          args = { "--disable", "MD013", "MD025", "--" },
        },
      },
    },
  },
}
