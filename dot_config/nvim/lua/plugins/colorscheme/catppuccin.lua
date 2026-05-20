---@type LazySpec
return {
  {
    "catppuccin/nvim",
    tag = "v2.0.0",
    name = "catppuccin",
    priority = 1000,
    opts = {
      color_overrides = {
        -- https://github.com/catppuccin/nvim/discussions/323#discussioncomment-10508447
        latte = {
          rosewater = "#fdf7e8",
          flamingo = "#cb4b16",
          pink = "#d33682",
          mauve = "#6c71c4",
          red = "#dc322f",
          maroon = "#c03260",
          peach = "#cb4b1f",
          yellow = "#b58900",
          green = "#859900",
          teal = "#2aa198",
          sky = "#2398d2",
          sapphire = "#0077b3",
          blue = "#268bd2",
          lavender = "#7b88d3",
          text = "#657b83",
          subtext1 = "#586e75",
          subtext0 = "#073642",
          overlay2 = "#002b36",
          overlay1 = "#839496",
          overlay0 = "#93a1a1",
          surface2 = "#eee8d5",
          surface1 = "#ebecef",
          surface0 = "#ccd0da",
          base = "#fdf6e3",
          mantle = "#f7f1dc",
          crust = "#f5ecd7",
        },
        macchiato = {
          rosewater = "#eee8d5", -- base2 (warm light tint, replaces near-white from latte)
          flamingo = "#cb4b16", -- orange
          pink = "#d33682", -- magenta
          mauve = "#6c71c4", -- violet
          red = "#dc322f", -- red
          maroon = "#c03260", -- between red and magenta
          peach = "#cb4b1f", -- orange variant
          yellow = "#b58900", -- yellow
          green = "#859900", -- green
          teal = "#2aa198", -- cyan
          sky = "#2398d2", -- sky blue
          sapphire = "#0077b3", -- deeper blue
          blue = "#268bd2", -- blue
          lavender = "#7b88d3", -- lavender
          text = "#839496", -- base0 (primary text in dark)
          subtext1 = "#93a1a1", -- base1
          subtext0 = "#657b83", -- base00
          overlay2 = "#586e75", -- base01
          overlay1 = "#073642", -- base02
          -- overlay0 = "#0a3845", -- slightly above base02
          surface2 = "#073642", -- base02 (elevated surface)
          -- surface1 = "#062f3b", -- between base02 and base03
          -- surface0 = "#042830", -- just above base03
          base = "#002b36", -- base03 (main background)
          mantle = "#001f29", -- slightly darker than base03
          crust = "#001520", -- darkest
        },
      },
      highlight_overrides = {
        -- https://github.com/catppuccin/nvim/discussions/323#discussioncomment-10508447
        latte = function(C)
          return {
            FlashLabel = { fg = C.base, bg = C.red, style = { "bold" } },
          }
        end,
        macchiato = function(C)
          return {
            FlashLabel = { fg = C.base, bg = C.red, style = { "bold" } },
          }
        end,
      },
    },
  },
}
