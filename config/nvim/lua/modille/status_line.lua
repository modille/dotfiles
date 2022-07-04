-- https://github.com/hoob3rt/lualine.nvim
local function vim_icon()
  return '  '
end

local function fileformat_warning()
  if vim.bo.fileformat == 'dos' then
    return 'dos!'
  end

  return nil
end

local hour = tonumber(os.date('%H'))

require('lualine').setup({
  options = {
    icons_enabled = true,
    -- A job could switch these automatically, but for now just choose one at startup
    -- theme = (hour < 6 or hour > 17) and 'solarized_dark' or 'solarized_light',
    theme = (hour < 6 or hour > 17) and 'solarized_dark' or 'solarized',
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
        symbols = { error = '﯇ ', warn = ' ', info = ' ', hint = ' ' },
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
