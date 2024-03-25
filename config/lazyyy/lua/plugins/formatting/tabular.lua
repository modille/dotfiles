return {
  {
    "godlygeek/tabular", -- For aligning text
    keys = {
      { "<leader>a=", "<cmd>Tabularize /=<CR>", mode = { "n", "v" } },
      { "<leader>a|", "<cmd>Tabularize /|<CR>", mode = { "n", "v" } },
      { "<leader>a:", "<cmd>Tabularize /:\zs/l0l1<CR>", mode = { "n", "v" } },
    },
  },
}
