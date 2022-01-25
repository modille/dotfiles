-- https://github.com/nvim-treesitter/nvim-treesitter
require('nvim-treesitter.configs').setup({
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
  },
  ignore_install = { 'jsdoc' },
  -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
  context_commentstring = {
    enable = true,
  },
})

-- https://github.com/code-biscuits/nvim-biscuits#configuration
require('nvim-biscuits').setup({
  toggle_keybind = '<leader>cb',
  default_config = {
    prefix_string = '🍪 ',
  },
})
