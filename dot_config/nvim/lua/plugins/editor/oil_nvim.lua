---@type LazySpec
return {
  {
    "stevearc/oil.nvim",
    lazy = false, -- so that it works with "nvim ./directory"
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      {
        "-",
        function()
          require("oil").open()
        end,
      },
    },
  },
}
