-- https://github.com/hoob3rt/lualine.nvim
local function vim_icon() return '  ' end
local function fileformat_warning()
  if vim.bo.fileformat == 'dos' then
    return 'dos!'
  end

  return nil
end
require'lualine'.setup {
  options = {
    icons_enabled = true,
    -- theme = 'solarized_dark',
    theme = 'solarized_light',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = {vim_icon},
    lualine_b = {
      {
        'branch',
        icon = '',
      }
    },
    lualine_c = {'filename'},
    lualine_x = {
      {
        'diagnostics',
        sources = {'nvim_lsp'},
        sections = {'error', 'warn', 'info', 'hint'},
        symbols = {error = '﯇ ', warn = ' ', info = ' ', hint = ' '},
      },
      {'filetype'},
    },
    lualine_y = {fileformat_warning, 'location'},
    lualine_z = {},
  },
  -- For an inactive window pane
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {'quickfix'}
}
