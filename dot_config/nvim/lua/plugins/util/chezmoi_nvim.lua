--- @type LazySpec
return {
  {
    "xvzc/chezmoi.nvim", -- edit chezmoi-managed files
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("chezmoi").setup({
        -- your configurations
      })
    end,
  },
}
