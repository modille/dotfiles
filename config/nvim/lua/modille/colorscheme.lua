local M = {}

-- reminder: as of nvim 0.9, you can use :Inspect and :InspectTree

function M.reload()
  local _, solarized = pcall(require, 'solarized')
  solarized.setup({
    theme = 'default',
    transparent = false,
    highlights = function(colors, colorhelper)
      -- local darken = colorhelper.darken
      local lighten = colorhelper.lighten
      local blend = colorhelper.blend
      return {
        -- better :intro
        SpecialKey = { link = 'Special' },

        -- more readable inlay hints
        LspInlayHint = { fg = lighten(colors.base01, 10), italic = true },

        -- italic for builtins
        ['@variable.builtin'] = { fg = colors.blue, italic = true }, -- Function + italic

        -- keep syntax highlighting in diffs
        -- (using these "Custom" groups + link is the only way to replace a default theme hl)
        CustomDiffAdd = { bg = blend(colors.add, colors.base03, 0.15) },
        CustomDiffChange = { bg = blend(colors.change, colors.base03, 0.15) },
        CustomDiffDelete = { bg = blend(colors.delete, colors.base03, 0.15) },
        CustomDiffText = { bg = blend(colors.blue, colors.base03, 0.15) },
        DiffAdd = { link = 'CustomDiffAdd' },
        DiffChange = { link = 'CustomDiffChange' },
        DiffDelete = { link = 'CustomDiffDelete' },
        DiffText = { link = 'CustomDiffText' },
        DiffAdded = { fg = colors.add },
        DiffChanged = { fg = colors.change },
        DiffRemoved = { fg = colors.delete },
        DiffFile = { fg = colors.base01 },
        DiffIndexLine = { fg = colors.violet },
        ['@text.diff.add'] = { link = 'DiffAdd' },
        ['@text.diff.delete'] = { link = 'DiffDelete' },

        -- neotest
        NeotestPassed = { fg = colors.green },
        NeotestFailed = { fg = colors.red },
        NeotestRunning = { fg = colors.yellow },
        NeotestSkipped = { fg = colors.cyan },
        NeotestNamespace = { fg = colors.blue },
        NeotestFocused = { link = 'CursorLine' },
        NeotestFile = { fg = colors.base0 },
        NeotestDir = { link = 'Directory' },
        NeotestIndent = { fg = colors.base01 },
        NeotestExpandMarker = { fg = colors.base01 },
        NeotestAdapterName = { fg = colors.violet },
        -- NeotestWinSelect = {},
        -- NeotestMarked = {},
        -- NeotestTarget = {},
        NeotestWatching = { link = 'NeotestRunning' },

        -- octo
        OctoGreenFloat = { fg = colors.green, bg = colors.base02 },
        OctoRedFloat = { fg = colors.red, bg = colors.base02 },
        OctoPurpleFloat = { fg = colors.violet, bg = colors.base02 },
        OctoYellowFloat = { fg = colors.yellow, bg = colors.base02 },
        OctoBlueFloat = { fg = colors.blue, bg = colors.base02 },
        OctoGreyFloat = { fg = colors.base0, bg = colors.base02 },
        OctoFilePanelTitle = { fg = colors.blue, bold = true },
        OctoFilePanelCounter = { fg = colors.violet, bold = true },
        OctoNormalFront = { fg = colors.base0 },
        OctoViewer = { fg = colors.blue, reverse = true },
        OctoEditable = { bg = colors.base02 },

        -- nvim-dap
        DebugBreakpoint = { fg = colors.red },
        DebugBreakpointLine = { fg = colors.red },
        DebugHighlight = { fg = colors.blue },
        DebugHighlightLine = { fg = colors.violet },
        NvimDapVirtualText = { fg = colors.cyan },

        -- nvim-dap-ui
        DapUIScope = { bg = colors.blue, fg = colors.base03 },
        DapUIType = { fg = colors.blue },
        DapUIDecoration = { fg = colors.blue },
        DapUIModifiedValue = { fg = colors.cyan },
        DapUIThread = { fg = colors.purple },
        DapUIStoppedThread = { bg = colors.purple, fg = colors.base03 },
        DapUIFloatBorder = { bg = colors.base03, fg = colors.base01 },
        DapUILineNumber = { fg = colors.base01 },
        DapUIFrameName = { fg = colors.base0 },
        DapUISource = { fg = colors.purple },
        DapUIBreakpointsPath = { bg = colors.yellow, fg = colors.base03 },
        DapUIBreakpointsInfo = { fg = colors.base0 },
        DapUIBreakpointsCurrentLine = { fg = colors.yellow },
        DapUIBreakpointsLine = { link = 'DapUIBreakpointsCurrentLine' },
        DapUIWatchesEmpty = { bg = colors.red, fg = colors.base03 },
        DapUIWatchesValue = { fg = colors.red },
        DapUIWatchesError = { fg = colors.red },

        -- Telescope
        CustomTelescopeSelection = { fg = colors.base2, bg = colors.base03 },
        TelescopeSelection = { link = 'CustomTelescopeSelection' },
      }
    end,
  })
  vim.cmd.colorscheme('solarized')
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
  if vim.fn.system('defaults read -g AppleInterfaceStyle'):gsub('\n', ''):sub(-4) == 'Dark' then
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
