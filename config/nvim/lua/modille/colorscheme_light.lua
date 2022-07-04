-- vim.o.termguicolors = true
-- vim.o.background = 'light'
-- local base16 = require('base16')
-- base16(base16.themes['solarized-light'], true)

-- TODO fork so that:
-- 1) italic comments does not include bold style for TSComment
-- 2) spelling errors are not italic
vim.o.background = 'light'
vim.g.solarized_italic_comments = true
vim.g.solarized_italic_keywords = false
vim.g.solarized_italic_functions = false
vim.g.solarized_italic_variables = false
vim.g.solarized_contrast = false
vim.g.solarized_borders = true
vim.g.solarized_disable_background = false
require('solarized').set()
-- Fix https://github.com/shaunsingh/solarized.nvim/issues/3
vim.cmd('highlight Identifier ctermfg=13 guifg=' .. require('solarized.colors').purple)

-- vim.o.termguicolors = true
-- vim.o.background = 'light'
-- vim.cmd('colorscheme soluarized')
