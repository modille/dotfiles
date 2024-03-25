return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    keys = {
      {
        "<leader>rp",
        function()
          require("refactoring").debug.printf({ below = false })
        end,
        mode = { "n" },
      },
      {
        "<leader>rv",
        function()
          require("refactoring").debug.print_var({ below = false })
        end,
        mode = { "n", "v" },
      },
      {
        "<leader>rc",
        function()
          require("refactoring").debug.cleanup({})
        end,
        mode = { "n" },
      },
    },
  },
}
