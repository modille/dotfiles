local M = {}

function M.setup()
  local function vim_icon()
    return '  '
  end

  local function fileformat_warning()
    if vim.bo.fileformat == 'dos' then
      return 'dos!'
    end

    return ''
  end

  -- TODO: Fix so that maxmx03/solarized.nvim overrides the builtin theme
  local solarized = require('solarized')
  local chromatic = require('solarized.utils.chromatic')
  local colors = solarized.colors
  local lighten = chromatic.lighten
  local solarized_theme = {
    normal = {
      a = { fg = lighten(colors.blue, 50), bg = colors.blue, gui = 'bold' },
      b = { fg = colors.bg_alt, bg = colors.content },
      c = { fg = colors.content, bg = solarized:is_transparent(colors.bg_alt) },
      z = { fg = lighten(colors.blue, 50), bg = colors.blue },
    },
    insert = {
      a = { fg = lighten(colors.green, 50), bg = colors.green },
    },
    visual = {
      a = { fg = lighten(colors.magenta, 50), bg = colors.magenta },
    },
    replace = {
      a = { fg = lighten(colors.red, 50), bg = colors.red },
    },
    command = {
      a = { fg = colors.blue, bg = lighten(colors.blue, 50) },
    },
  }

  -- https://github.com/hoob3rt/lualine.nvim
  require('lualine').setup({
    options = {
      icons_enabled = true,
      theme = solarized_theme,
      component_separators = { '', '' },
      section_separators = { '', '' },
      disabled_filetypes = {},
    },
    sections = {
      lualine_a = { vim_icon },
      lualine_b = {
        {
          'branch',
          icon = '',
        },
      },
      lualine_c = {
        {
          'filename',
          file_status = true,
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
      },
      lualine_x = {
        {
          'diagnostics',
          sources = { 'nvim_diagnostic' },
          sections = { 'error', 'warn', 'info', 'hint' },
          symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
        },
        { 'filetype' },
      },
      lualine_y = { fileformat_warning, 'location' },
      lualine_z = {},
    },
    -- For an inactive window pane
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          'filename',
          file_status = true,
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
      },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = { 'quickfix' },
  })
end

return M
