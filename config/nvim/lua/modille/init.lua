-- Order matters
require('modille.options')

require('modille.completion')
require('modille.debuggers')
require('modille.fuzzy_finder')
require('modille.lsp')
require('modille.status_line_light')
require('modille.treesitter')

-- https://github.com/lewis6991/gitsigns.nvim
require'gitsigns'.setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '┃', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
}

-- https://github.com/norcalli/nvim-colorizer.lua
require'colorizer'.setup()

-- https://github.com/lukas-reineke/indent-blankline.nvim
require'indent_blankline'.setup {
  use_treesitter = true,
  show_first_indent_level = false,
  buftype_exclude = {'help', 'terminal', 'startify'},
  filetype_exclude = {'help', 'terminal', 'startify'},
  show_current_context = true, -- Note: With this option enabled, the plugin refreshes on |CursorMoved|, which might be slower
  context_patterns = {'call', 'class', 'function', 'method', 'pair'},
}

-- https://github.com/phaazon/hop.nvim
require'hop'.setup()
vim.api.nvim_set_keymap('n', '<leader><leader>w', "<cmd>lua require'hop'.hint_words()<cr>", {})
vim.api.nvim_set_keymap('n', '<leader><leader>l', "<cmd>lua require'hop'.hint_lines()<cr>", {})
vim.api.nvim_set_keymap('n', '<leader><leader>c', "<cmd>lua require'hop'.hint_char1()<cr>", {})
