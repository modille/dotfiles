-- Use space for leader since thumbs rest there
vim.g.mapleader = " "

-- Disable Perl since it's unused
vim.g.loaded_perl_provider = 0

-- Disable Python2 check since it's EOL
vim.g.loaded_python2_provider = 0

vim.g.lazyvim_python_lsp = "basedpyright" -- try basedpyright for using with poetry
vim.g.lazyvim_ruby_lsp = "ruby_lsp"
vim.g.lazyvim_ruby_formatter = "standardrb"

-- https://github.com/vim/vim/issues/4738
vim.g.netrw_browsex_viewer = "open"

-- CTRL-^ returns to last edited file instead of netrw browsing buffer
vim.g.netrw_altfile = 1

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("modille.colorscheme").setup()
