-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("modille_" .. name, { clear = true })
end

-- Custom filetype/syntax
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("ruby"),
  pattern = { "Berksfile", "Guardfile", "Vagrantfile" },
  command = "set syntax=ruby",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("pem"),
  pattern = "*.pem",
  command = "set filetype=pem",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("json5"),
  pattern = ".twilioserverlessrc",
  command = "set filetype=json5",
})

-- Templates
vim.api.nvim_create_autocmd("BufNewFile", {
  group = augroup("skeleton_rb"),
  pattern = "*.rb",
  command = "0r ~/git/github.com/modille/dotfiles/tag-vim/templates/skeleton.rb",
})
vim.api.nvim_create_autocmd("BufNewFile", {
  group = augroup("skeleton_sh"),
  pattern = "*.sh",
  command = "0r ~/git/github.com/modille/dotfiles/tag-vim/templates/skeleton.sh",
})
vim.api.nvim_create_autocmd("BufNewFile", {
  group = augroup("skeleton_gemfile"),
  pattern = "Gemfile",
  command = "0r ~/git/github.com/modille/dotfiles/tag-vim/templates/Gemfile",
})

-- https://www.lazyvim.org/configuration/tips#disable-autoformat-for-some-buffers
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("autoformat"),
  pattern = { "yaml" },
  callback = function()
    vim.b.autoformat = false
  end,
})
