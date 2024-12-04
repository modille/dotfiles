return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        fish = { "fish_indent" },
        javascript = { "eslint_d" },
        kotlin = { "ktlint" },
        lua = { "stylua" },
        markdown = { "prettier" },
        sh = { "shfmt" },
        xml = { "xmllint" },
        yaml = {},
      },
    },
  },
}
