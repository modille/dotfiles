-- Use space for leader since thumbs rest there
vim.g.mapleader = ' '

-- Disable Perl since it's unused
vim.g.loaded_perl_provider = 0

-- Disable Python2 check since it's EOL
vim.g.loaded_python2_provider = 0

-- Use python3 binary from Homebrew
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'

-- Use frum installation for ruby
-- vim.g.ruby_host_prog = os.getenv('HOME') .. '/.frum/versions/3.0.6/bin/neovim-ruby-host'
vim.g.ruby_host_prog = os.getenv('HOME') .. '/.frum/versions/3.2.3/bin/neovim-ruby-host'

-- https://github.com/vim/vim/issues/4738
vim.g.netrw_browsex_viewer = 'open'

-- CTRL-^ returns to last edited file instead of netrw browsing buffer
vim.g.netrw_altfile = 1
