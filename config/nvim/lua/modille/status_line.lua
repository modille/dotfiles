local function load(theme)
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

  require('lualine').setup({
    options = {
      icons_enabled = true,
      theme = theme,
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
end

return {
  load = load,
}
