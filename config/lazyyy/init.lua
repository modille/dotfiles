-- Use space for leader since thumbs rest there
vim.g.mapleader = " "

-- Disable Perl since it's unused
vim.g.loaded_perl_provider = 0

-- Disable Python2 check since it's EOL
vim.g.loaded_python2_provider = 0

-- Use python3 binary from Homebrew
vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

-- Use frum installation for ruby
-- TODO switch based on project
vim.g.ruby_host_prog = os.getenv("HOME") .. "/.frum/versions/3.3.1/bin/neovim-ruby-host"
vim.g.lazyvim_ruby_lsp = "ruby_lsp"
vim.g.lazyvim_ruby_formatter = "standardrb"

-- vim.g.ruby_host_prog = os.getenv("HOME") .. "/.frum/versions/3.2.3/bin/neovim-ruby-host"
-- vim.g.lazyvim_ruby_lsp = "solargraph"
-- vim.g.lazyvim_ruby_formatter = "rubocop"

-- https://github.com/vim/vim/issues/4738
vim.g.netrw_browsex_viewer = "open"

-- CTRL-^ returns to last edited file instead of netrw browsing buffer
vim.g.netrw_altfile = 1

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("modille.colorscheme").setup()
