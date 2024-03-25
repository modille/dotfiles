return {
  {
    "pwntester/octo.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      enable_builtin = true, -- shows a list of builtin actions when no action is provided
      timeline_marker = "└",
    },
    keys = {
      { "<leader>O", "<cmd>Octo<cr>" },
    },
  },
}
