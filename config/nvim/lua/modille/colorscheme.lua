local M = {}

function M.reload()
  local _, solarized = pcall(require, 'solarized')
  solarized:setup({
    config = {
      theme = 'neovim',
      transparent = false,
    },
    highlights = function(colors, darken, lighten, blend)
      return {
        -- better :intro
        SpecialKey = { link = 'Special' },

        -- keep syntax highlighting in diffs
        DiffText = { bg = blend(colors.blue, colors.bg, 0.15) },
        DiffAdd = { bg = blend(colors.added, colors.bg, 0.15) },
        DiffChange = { bg = blend(colors.changed, colors.bg, 0.15) },
        DiffDelete = { bg = blend(colors.removed, colors.bg, 0.15) },
        DiffAdded = { fg = colors.added },
        DiffChanged = { fg = colors.changed },
        DiffRemoved = { fg = colors.removed },
        DiffFile = { fg = colors.comment },
        DiffIndexLine = { fg = colors.violet },
        ['@text.diff.add'] = { link = 'DiffAdd' },
        ['@text.diff.delete'] = { link = 'DiffDelete' },
      }
    end,
  })
  vim.cmd('colorscheme solarized')
  require('modille.status_line').setup()
end

function M.dark()
  vim.o.background = 'dark'
  M.reload()
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
end

function M.light()
  vim.o.background = 'light'
  M.reload()
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
end

function M.setup()
  -- Read and store current system theme
  if vim.fn.system('defaults read -g AppleInterfaceStyle'):sub(1, 4) == 'Dark' then
    vim.g.modille_background = 'dark'
  else
    vim.g.modille_background = 'light'
  end

  -- Load light/dark colorscheme and status line based on current system theme
  if vim.g.modille_background == 'dark' then
    M.dark()
  else
    M.light()
  end

  -- Auto-switch light/dark colorscheme and status line based on SIGWINCH
  local Job = require('plenary.job')
  require('bgwinch').setup({
    set_bg = function()
      local j = Job:new({ command = 'defaults', args = { 'read', '-g', 'AppleInterfaceStyle' } })
      j:sync()
      if j:result()[1] == 'Dark' and vim.g.modille_background == 'light' then
        vim.g.modille_background = 'dark'
        M.dark()
      elseif vim.g.modille_background == 'dark' then
        vim.g.modille_background = 'light'
        M.light()
      end
    end,
  })
end

return M
