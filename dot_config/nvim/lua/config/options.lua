-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- See:
-- :options (vim docs, split into categories)
-- :help options (nvim docs, alphabetical)
-- :help vim.opt

-- 4 displaying text
vim.opt.relativenumber = false
vim.opt.wrap = true

-- 5 syntax, highlighting and spelling
-- vim.opt.colorcolumn = "80"

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

-- 24 various
vim.opt.exrc = true

-- other
vim.opt.pumblend = 0 -- Fully opaque popup-menu (completion)
vim.opt.shada = {
  "!", -- Save and restore global variables (default enabled)
  "'1000", -- Save marks for the last 1000 files (default 100)
  "<5000", -- Save up to 5000 lines for each register (default 50)
  "s100", -- Max size of an item in megabytes (100MB) (default 10)
  "%", -- Save and restore the buffer list (default disabled)
  ":10000", -- Save the last 10000 commands in history (default disabled)
  "/10000", -- Save the last 10000 search patterns in history (default disabled)
  "@10000", -- Save and restore the input-line history (default disabled)
}
