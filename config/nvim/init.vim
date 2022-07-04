if has('vim_starting')
  set runtimepath+=~/git/github.com/modille/dotfiles/tag-vim/
endif

" Auto-install vim-plug
let data_dir = '~/git/github.com/modille/dotfiles/tag-vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/git/github.com/modille/dotfiles/tag-vim/plugged')

" Language support
Plug 'blankname/vim-fish',               { 'for': 'fish' }
Plug 'briancollins/vim-jst',             { 'for': 'ejs' }
Plug 'cespare/vim-toml',                 { 'for': 'toml' }
Plug 'craigdallimore/vim-jest-cli',      { 'for': 'javascript' }
Plug 'docker/docker',                    { 'for': 'dockerfile', 'rtp': 'contrib/syntax/vim' }
Plug 'fatih/vim-go',                     { 'for': ['asm', 'go', 'gohtmltmpl'] }
Plug 'modille/groovy.vim',               { 'for': 'groovy' }
Plug 'modille/vim-search-maven',         { 'for': 'groovy', 'branch': 'gradle' }
Plug 'mustache/vim-mustache-handlebars', { 'for': 'mustache' }
Plug 'maxmellon/vim-jsx-pretty',         { 'for': 'javascript' }
Plug 'nginx/nginx',                      { 'rtp': 'contrib/vim' }
Plug 'pangloss/vim-javascript',          { 'for': 'javascript' }
Plug 'tmux-plugins/vim-tmux',            { 'for': 'tmux' }
Plug 'tpope/vim-markdown',               { 'for': 'markdown' }
Plug 'elzr/vim-json'
Plug 'notriddle/vim-gitcommit-markdown'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-rails'

" Text objects
Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-function' | Plug 'Julian/vim-textobj-variable-segment' | Plug 'glts/vim-textobj-comment' | Plug 'haya14busa/vim-textobj-function-syntax'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }
Plug 'vim-scripts/argtextobj.vim'

" Other plugins
Plug 'azabiong/vim-highlighter'
Plug 'brooth/far.vim'
Plug 'dbeniamine/cheat.sh-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular' " For aligning text
Plug 'haya14busa/is.vim' " Incremental search
Plug 'haya14busa/vim-asterisk'
Plug 'ivyl/vim-bling'
Plug 'janko-m/vim-test'
Plug 'machakann/vim-highlightedyank'
Plug 'mzlogin/vim-markdown-toc'
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch' | Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive' | Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tweekmonster/startuptime.vim'

if has('nvim')
  " Utils
  Plug 'nvim-lua/plenary.nvim'

  " Treesitter
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  Plug 'modille/nvim-base16.lua' " Props to https://github.com/norcalli ❤️
  " Plug 'ishan9299/nvim-solarized-lua'
  " Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
  Plug 'danymat/neogen'
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  Plug 'code-biscuits/nvim-biscuits'
  Plug 'ThePrimeagen/refactoring.nvim'
  Plug 'shaunsingh/solarized.nvim'
  Plug 'Iron-E/nvim-soluarized'

  " Fuzzy finder
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  Plug 'Kapeli/dash.nvim'

  " LSP
  Plug 'neovim/nvim-lspconfig'
  Plug 'kosayoda/nvim-lightbulb' " Show gutter sign when action is available
  Plug 'stevearc/aerial.nvim'
  Plug 'b0o/schemastore.nvim'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
  Plug 'folke/trouble.nvim'

  " Completion
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-calc'
  Plug 'hrsh7th/cmp-path'

  " Snippets
  Plug 'hrsh7th/vim-vsnip'
  Plug 'rafamadriz/friendly-snippets'

  " Status line
  Plug 'hoob3rt/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'

  " Debugging
  Plug 'mfussenegger/nvim-dap'
  Plug 'nvim-telescope/telescope-dap.nvim'
  Plug 'theHamsta/nvim-dap-virtual-text'
  Plug 'rcarriga/nvim-dap-ui'
  Plug 'David-Kunz/jester' " Debug jest tests

  " Other
  " http://vim.wikia.com/wiki/Replace_a_word_with_yanked_text
  " Consider yi" then ci"<C-R>0 then . to repeat
  Plug 'bfredl/nvim-miniyank'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'lewis6991/impatient.nvim'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'lukas-reineke/indent-blankline.nvim'
  Plug 'phaazon/hop.nvim', { 'branch': 'v1' }
endif

call plug#end()

" https://github.com/lewis6991/impatient.nvim#setup
" Impatient needs to be setup before any other lua plugin is loaded
lua require('impatient')

" Always seems to work best if these are done early
lua require('modille.colorscheme')

" Are these still needed nowadays?
" filetype indent on
" filetype plugin on
" syntax enable

" Use space for leader since thumbs rest there
let mapleader = " "

" Disable Python2 check since it's EOL
let g:loaded_python2_provider = 0

" Use python3 binary from Homebrew
let g:python3_host_prog = '/opt/homebrew/bin/python3'

" https://github.com/tpope/vim-markdown/pull/135
let g:markdown_folding = 1

let g:HiSet   = 'f<CR>'           " normal, visual
let g:HiClear = 'f<BS>'           " normal, visual
let g:HiErase = 'f<C-L>'          " normal
let g:HiFind  = 'f<Tab>'          " normal, visual

" Personal lua module
lua require('modille')
