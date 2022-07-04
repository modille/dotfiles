-- Use space for leader since thumbs rest there
vim.g.mapleader = ' '

-- Disable Python2 check since it's EOL
vim.g.loaded_python2_provider = 0

-- Use python3 binary from Homebrew
vim.g.python3_host_prog = '/opt/homebrew/bin/python3'

-- Use rbenv installation for ruby
vim.g.ruby_host_prog = os.getenv('HOME') .. '/.rbenv/versions/3.0.2/bin/neovim-ruby-host'

-- https://github.com/tpope/vim-markdown/pull/135
vim.g.markdown_folding = 1
