return {
  {
    'olimorris/onedarkpro.nvim',
    enabled = false,
    lazy = true,
    priority = 1000,
    opts = {
      colors = {
        bg = '#fdf6e3',
        -- fg = '#657b83',
        red = '#dc322f',
        orange = '#b58900',
        yellow = '#cb4b16',
        green = '#859900',
        cyan = '#2aa198',
        blue = '#268bd2',
        purple = '#6c71c4',
        white = '#fdf6e3',
        -- black = '#657b83',
        -- gray = '#93a1a1',
        -- highlight = '#839496',
        -- comment = '#93a1a1',
      }, -- Override default colors or create your own
    },
    config = true,
  },
  {
    'folke/tokyonight.nvim',
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {
      style = 'storm',      -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      light_style = 'day',  -- The theme is used when the background is set to light
      day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    },
  },
  {
    'EdenEast/nightfox.nvim',
    enabled = false,
    config = false,
  },
  {
    'catppuccin/nvim',
    enabled = false,
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'latte', -- latte, frappe, macchiato, mocha
      background = {
        light = 'latte',
        dark = 'frappe',
      },
    },
  },
  {
    'sainnhe/everforest',
    enabled = false,
  },
  {
    'maxmx03/solarized.nvim',
    config = false,
  },
  {
    'craftzdog/solarized-osaka.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
