---@type LazySpec
return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        kotlin = { "ktlint" },
        sh = { "shellcheck" },
        -- ruby = { "ruby", "standardrb" },
      },
      linters = {
        markdownlint = {
          args = { "--disable", "MD013", "MD025", "--" },
        },
      },
    },
  },
}
