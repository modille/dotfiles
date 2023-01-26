-- -- Order matters
-- require('modille.plugins')
-- require('modille.options')
-- -- require('modille.colorscheme')

-- -- require('modille.startup')
-- -- require('modille.completion')
-- -- require('modille.debuggers')
-- -- require('modille.fuzzy_finder')
-- -- require('modille.lsp')
-- -- require('modille.status_line')
-- -- require('modille.treesitter')

-- -- https://github.com/lewis6991/gitsigns.nvim
-- -- stylua: ignore start
-- require'gitsigns'.setup {
--   signs = {
--     add          = {hl = 'GitSignsAdd'   , text = '┃', numhl = 'GitSignsAddNr'   , linehl = 'GitSignsAddLn'},
--     change       = {hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
--     delete       = {hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
--     topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
--     changedelete = {hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'},
--   },
-- }
-- -- stylua: ignore end

-- -- https://github.com/norcalli/nvim-colorizer.lua
-- require('colorizer').setup()

-- -- https://github.com/lukas-reineke/indent-blankline.nvim
-- require('indent_blankline').setup({
--   use_treesitter = true,
--   show_first_indent_level = false,
--   buftype_exclude = { 'alpha', 'help', 'terminal', 'startify' },
--   filetype_exclude = { 'alpha', 'help', 'terminal', 'startify' },
--   show_current_context = true, -- Note: With this option enabled, the plugin refreshes on |CursorMoved|, which might be slower
--   context_patterns = { 'call', 'class', 'function', 'method', 'pair' },
-- })

-- -- https://github.com/phaazon/hop.nvim
-- require('hop').setup()
-- vim.api.nvim_set_keymap('n', '<leader><leader>w', "<cmd>lua require'hop'.hint_words()<cr>", {})
-- vim.api.nvim_set_keymap('n', '<leader><leader>l', "<cmd>lua require'hop'.hint_lines()<cr>", {})
-- vim.api.nvim_set_keymap('n', '<leader><leader>c', "<cmd>lua require'hop'.hint_char1()<cr>", {})
-- vim.api.nvim_set_keymap('v', '<leader><leader>w', "<cmd>lua require'hop'.hint_words()<cr>", {})
-- vim.api.nvim_set_keymap('v', '<leader><leader>l', "<cmd>lua require'hop'.hint_lines()<cr>", {})
-- vim.api.nvim_set_keymap('v', '<leader><leader>c', "<cmd>lua require'hop'.hint_char1()<cr>", {})

-- -- https://github.com/danymat/neogen
-- require('neogen').setup({})

-- -- https://github.com/nvim-treesitter/nvim-treesitter/issues/1167#issuecomment-920824125
-- function _G.javascript_indent()
--   local line = vim.fn.getline(vim.v.lnum)
--   local prev_line = vim.fn.getline(vim.v.lnum - 1)
--   if line:match('^%s*[%*/]%s*') then
--     if prev_line:match('^%s*%*%s*') then
--       return vim.fn.indent(vim.v.lnum - 1)
--     end
--     if prev_line:match('^%s*/%*%*%s*$') then
--       return vim.fn.indent(vim.v.lnum - 1) + 1
--     end
--   end

--   return vim.fn['GetJavascriptIndent']()
-- end
-- vim.cmd([[autocmd FileType javascript setlocal indentexpr=v:lua.javascript_indent()]])
