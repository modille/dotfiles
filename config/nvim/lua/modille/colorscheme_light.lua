local function load()
  -- vim.o.termguicolors = true
  -- vim.o.background = 'light'
  -- local base16 = require('base16')
  -- base16(base16.themes['solarized-light'], true)

  --local Color = require('nightfox.lib.color')
  --require('nightfox').setup({
  --  options = {
  --    -- Compiled file's destination location
  --    compile_path = vim.fn.stdpath('cache') .. '/nightfox',
  --    compile_file_suffix = '_compiled', -- Compiled file suffix
  --    transparent = false, -- Disable setting background
  --    terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
  --    dim_inactive = false, -- Non focused panes set to alternative background
  --    styles = { -- Style to be applied to different syntax groups
  --      comments = 'NONE', -- Value is any valid attr-list value `:help attr-list`
  --      conditionals = 'NONE',
  --      constants = 'NONE',
  --      functions = 'NONE',
  --      keywords = 'NONE',
  --      numbers = 'NONE',
  --      operators = 'NONE',
  --      strings = 'NONE',
  --      types = 'NONE',
  --      variables = 'NONE',
  --    },
  --    inverse = { -- Inverse highlight for different types
  --      match_paren = false,
  --      visual = false,
  --      search = false,
  --    },
  --    modules = { -- List of various plugins and additional options
  --      -- ...
  --    },
  --  },
  --  palettes = {

  --    all = {
  --      -- Each palette defines these colors:
  --      --   black, red, green, yellow, blue, magenta, cyan, white, orange, pink
  --      --
  --      -- These colors have 3 shades: base, bright, and dim
  --      --
  --      -- Defining just a color defines it's base color
  --      black = '#002b36',
  --      red = '#dc322f',
  --      green = '#859900',
  --      yellow = '#b58900',
  --      blue = '#268bd2',
  --      magenta = '#d33682',
  --      cyan = '#2aa198',
  --      white = '#fafafa',
  --      orange = '#cb4b16',
  --      pink = '#6c71c4',
  --    },

  --    dawnfox = {
  --      -- A palette also defines the following:
  --      --   bg0, bg1, bg2, bg3, bg4, fg0, fg1, fg2, fg3, sel0, sel1, comment
  --      --
  --      -- These are the different foreground and background shades used by the theme.
  --      -- The base bg and fg is 1, 0 is normally the dark alternative. The others are
  --      -- incrementally lighter versions.
  --      bg0 = '#eee8d5',
  --      bg1 = '#fdf6e3',
  --      bg2 = Color.from_hex('#fdf6e3'):brighten(-5):to_hex(),
  --      bg3 = Color.from_hex('#fdf6e3'):brighten(-10):to_hex(),
  --      bg4 = Color.from_hex('#fdf6e3'):brighten(-15):to_hex(),
  --      fg0 = '#93a1a1',
  --      fg1 = '#657b83',
  --      fg2 = Color.from_hex('#657b83'):brighten(-20):to_hex(),
  --      fg3 = Color.from_hex('#657b83'):brighten(-25):to_hex(),
  --      fg4 = Color.from_hex('#657b83'):brighten(-30):to_hex(),

  --      -- sel is different types of selection colors.
  --      sel0 = '#eee8d5', -- Popup bg, visual selection bg
  --      sel1 = Color.from_hex('#eee8d5'):brighten(-5):to_hex(), -- Popup sel bg, search bg

  --      -- comment is the definition of the comment color.
  --      comment = '#93a1a1',
  --    },
  --  },
  --  specs = {},
  --  groups = {},
  --})
  --vim.cmd('colorscheme dawnfox')

  -- -- TODO fork so that:
  -- -- 1) italic comments does not include bold style for TSComment
  -- -- 2) spelling errors are not italic
  -- vim.o.background = 'light'
  -- vim.g.solarized_italic_comments = true
  -- vim.g.solarized_italic_keywords = false
  -- vim.g.solarized_italic_functions = false
  -- vim.g.solarized_italic_variables = false
  -- vim.g.solarized_contrast = false
  -- vim.g.solarized_borders = true
  -- vim.g.solarized_disable_background = false
  -- require('solarized').set()
  -- -- Fix https://github.com/shaunsingh/solarized.nvim/issues/3
  -- vim.cmd('highlight Identifier ctermfg=13 guifg=' .. require('solarized.colors').purple)

  -- -- vim.o.termguicolors = true
  -- -- vim.o.background = 'light'
  -- -- vim.cmd('colorscheme soluarized')

  -- -- require "nvim-treesitter.highlight"
  -- -- vim.TSHighlighter is removed, please use vim.treesitter.highlighter
  -- -- see https://github.com/neovim/neovim/pull/14145/commits/b5401418768af496ef23b790f700a44b61ad784d
  -- -- deactivate highlight of TSPunctBracket
  -- -- local hlmap = vim.treesitter.highlighter.hl_map
  -- -- hlmap["punctuation.bracket"] = nil

  -- local p = require('resolarized.palette')
  -- require('resolarized.scheme.dark').ColorColumn.bg = p.base02
  -- require('resolarized.scheme.dark').LineNr.bg = p.base02
  -- vim.cmd('colorscheme solarized')

  require('onedarkpro').setup({
    colors = {
      onelight = {
        -- colors matching the names:
        bg = '#fdf6e3',
        fg = '#6a6a6a',
        red = '#dc322f',
        orange = '#cb4b16',
        yellow = '#b58900',
        green = '#859900',
        cyan = '#2aa198',
        blue = '#268bd2',
        purple = '#6c71c4',
        white = '#fafafa',
        black = '#002b36',
        gray = '#586e75',
        highlight = '#eee8d5',
        comment = '#93a1a1',
        none = 'NONE',
      },
    },
    highlights = {
      ['@label.javascript'] = { fg = '${yellow}', style = 'bold' },
      ['@variable.javascript'] = { fg = '${fg}' },
      ['@variable.builtin.javascript'] = { fg = '${fg}', style = 'italic' },
      ['@parameter.javascript'] = { fg = '${yellow}', style = 'bold,italic' },
      ['@property.javascript'] = { fg = '${cyan}' },
      ['@label.ruby'] = { fg = '${yellow}', style = 'bold' },
      ['@variable.ruby'] = { fg = '${fg}' },
      ['@variable.builtin.ruby'] = { fg = '${fg}', style = 'italic' },
      ['@parameter.ruby'] = { fg = '${yellow}', style = 'bold,italic' },
      ['@property.ruby'] = { fg = '${cyan}' },

      ['@text.literal.markdown_inline'] = { fg = '${green}' },
      ['@text.reference.markdown_inline'] = { fg = '${blue}' },
      ['@text.strong.markdown_inline'] = { fg = '${fg}', style = 'bold' },
      ['@text.title.markdown'] = { fg = '${orange}', style = 'bold' },
      ['@parameter.markdown_inline'] = { fg = '${fg}' },
      ['@punctuation.special.markdown'] = { fg = '${yellow}' },
      ['@punctuation.delimiter.markdown_inline'] = { fg = '${fg}' },
      ['@text.uri.markdown_inline'] = { fg = '${purple}' },

      SpecialKey = { link = 'Special' },
      LineNr = { fg = '${fg}' },
    },
  })
  vim.o.background = 'light'
  vim.cmd('colorscheme onelight')
end

-- solarized light cheatsheet:
--   base3 = '#eee8d5', -- Background
--   base2 = '#fdf6e3', -- Background - highlights
--   base00 = '#657b83', -- Primary content - body
--   base1 = '#93a1a1', -- Secondary content - comments
--   base01 = '#586e75', -- Optional content - emphasis
--   yellow = '#b58900',
--   orange = '#cb4b16',
--   red = '#dc322f',
--   magenta = '#d33682',
--   violet = '#6c71c4',
--   blue = '#268bd2',
--   cyan = '#2aa198',
--   green = '#859900',

-- solarized dark cheatsheet:
--   base3 = '#002b36', -- Background
--   base2 = '#073642', -- Background - highlights
--   base00 = '#839496', -- Primary content - body
--   base1 = '#93a1a1', -- Secondary content - comments
--   base01 = '#586e75', -- Optional content - emphasis
--   yellow = '#b58900',
--   orange = '#cb4b16',
--   red = '#dc322f',
--   magenta = '#d33682',
--   violet = '#6c71c4',
--   blue = '#268bd2',
--   cyan = '#2aa198',
--   green = '#859900',

return {
  load = load,
}
