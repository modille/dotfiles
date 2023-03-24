return {
  {
    'hoob3rt/lualine.nvim',
    config = false,
    dependencies = {
      {
        'kyazdani42/nvim-web-devicons',
        init = function()
          -- specify OS to decide an icon for unix fileformat (not defined by default)
          -- this is useful for avoiding unnecessary system() call
          vim.g.WebDevIconsOS = 'Darwin'
        end,
      },
      { 'maxmx03/solarized.nvim' },
    },
  },
}
