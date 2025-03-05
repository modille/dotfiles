return {
  {
    "folke/tokyonight.nvim",
    opts = {
      -- on_colors = function(colors)
      --   colors.border = colors.blue0
      -- end,
      on_highlights = function(hl, c)
        -- https://github.com/folke/flash.nvim/discussions/130
        hl["FlashLabel"] = { fg = c.magenta2, bold = true }
      end,
    },
  },
}
