return {
  {
    "gbprod/yanky.nvim",
    keys = {
      { "<leader>p", false },
      {
        "<leader><leader>p",
        function()
          vim.cmd([[YankyRingHistory]])
        end,
        mode = { "n", "x" },
        desc = "Open Yank History",
      },
    },
  },
}
