return {
  {
    "gbprod/yanky.nvim",
    keys = {
      { "<leader>p", false },
      -- stylua: ignore
      { "<leader><leader>p", function() require("telescope").extensions.yank_history.yank_history({ }) end, mode = { "n", "x", "v" }, desc = "Open Yank History" },
    },
  },
}
