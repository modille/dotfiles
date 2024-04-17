return {
  {
    "gbprod/yanky.nvim",
    keys = {
      -- set LazyVim default <leader>p mapping for 'v' mode too
      -- stylua: ignore
      { "<leader>p", function() require("telescope").extensions.yank_history.yank_history({ }) end, mode = { "n", "x", "v" }, desc = "Open Yank History" },
    },
  },
}
