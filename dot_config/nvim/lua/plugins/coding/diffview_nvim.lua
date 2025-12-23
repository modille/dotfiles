---@type LazySpec
return {
  {
    "sindrets/diffview.nvim",
    keys = {
      {
        "<leader>cA",
        function()
          require("diffview.config").actions.conflict_choose("all")
        end,
      },
    },
  },
}
