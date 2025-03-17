return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
  },
}
