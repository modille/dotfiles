return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        fish = { "fish_indent" },
        sh = { "shfmt" },
        javascript = { "eslint_d" },
        markdown = { "prettier" },
        yaml = {},
        kotlin = { "ktlint" },
      },
    },
  },
}
