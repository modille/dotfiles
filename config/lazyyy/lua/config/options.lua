-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- See:
-- :options
-- :help vim.opt

-- 4 displaying text
vim.opt.relativenumber = false

-- 5 syntax, highlighting and spelling
vim.opt.colorcolumn = "80"

-- 11 selecting text
vim.opt.clipboard = "" -- don't sync with system clipboard
vim.keymap.set("v", "<Leader>y", '"+y')
vim.keymap.set("v", "<Leader>d", '"+d')
vim.keymap.set("n", "<Leader>p", '"+p')
vim.keymap.set("n", "<Leader>P", '"+P')
vim.keymap.set("v", "<Leader>p", '"+p')
vim.keymap.set("v", "<Leader>P", '"+P')

-- 18 reading and writing files
vim.opt.writebackup = false
vim.opt.backup = false
vim.opt.autoread = true

-- 19 the swap file
vim.opt.swapfile = false

vim.opt.pumblend = 0 -- Fully opaque popup-menu (completion)
