--- @type LazySpec
return {
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      dashboard = {
        enabled = false,
      },
      indent = {
        scope = {
          underline = false, -- underline the start of the scope
        },
      },
    },
  },
}
