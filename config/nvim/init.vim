" vim:fdm=marker
" vimrc

" ----------------------------------------------------------------------------
"  Vim package manager {{{1
" ----------------------------------------------------------------------------
" Setup {{{2
if has('vim_starting')
  set runtimepath+=~/git/github.com/modille/dotfiles/tag-vim/
endif

" Auto-install vim-plug
if empty(glob('~/git/github.com/modille/dotfiles/tag-vim/autoload/plug.vim'))
  silent !mkdir -p ~/git/github.com/modille/dotfiles/tag-vim/autoload
  silent !curl -fLo ~/git/github.com/modille/dotfiles/tag-vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/git/github.com/modille/dotfiles/tag-vim/plugged')

" Colorschemes {{{2
Plug 'chriskempson/base16-vim'
Plug 'marciomazza/vim-brogrammer-theme'
Plug 'sickill/vim-monokai'
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
Plug 'nanotech/jellybeans.vim'
Plug 'morhetz/gruvbox'

" Language support {{{2
Plug 'PProvost/vim-ps1',         { 'for': 'ps1' }
Plug 'cespare/vim-toml',         { 'for': 'toml' }
Plug 'elixir-lang/vim-elixir',   { 'for': ['eelixer', 'elixer'] }
Plug 'elzr/vim-json'
Plug 'fatih/vim-go',             { 'for': ['asm', 'go', 'gohtmltmpl'] }
Plug 'modille/groovy.vim',       { 'for': 'groovy' }
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
Plug 'nginx/nginx',              { 'rtp': 'contrib/vim' }
Plug 'nikolavp/vim-jape',        { 'for': 'jape' }
Plug 'notriddle/vim-gitcommit-markdown'
Plug 'tetsuo13/Vim-log4j'
Plug 'tmux-plugins/vim-tmux',    { 'for': 'tmux' }
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'wavded/vim-stylus',        { 'for': 'stylus' }
Plug 'wting/rust.vim',           { 'for': 'rust' }

" Text objects {{{2
Plug 'kana/vim-textobj-user' | Plug 'glts/vim-textobj-comment'
Plug 'vim-scripts/argtextobj.vim'

" Other plugins {{{2
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color' " Highlight colors in CSS files
Plug 'bronson/vim-trailing-whitespace'
" Plug 'dodie/vim-disapprove-deep-indentation'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
Plug 'heavenshell/vim-jsdoc'
Plug 'hwartig/vim-seeing-is-believing'
Plug 'jpalardy/spacehi.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug 'junegunn/rainbow_parentheses.vim', { 'on': ['RainbowParentheses'] }
Plug 'kshenoy/vim-signature' " Show marks in gutter
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-startify'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'rizzatti/dash.vim'
Plug 'schickling/vim-bufonly'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeFind', 'NERDTreeToggle'] } | Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'shougo/vimproc.vim', { 'do': 'make' }
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tweekmonster/startuptime.vim'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-session'

" Neovim-only plugins {{{2
if has('nvim')
  " Plug 'benekastah/neomake'
  Plug 'bfredl/nvim-miniyank'
  Plug 'kassio/neoterm'
  Plug 'osyo-manga/vim-brightest' " Highlight word under cursor
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets'
  " Plug 'valloric/YouCompleteMe', { 'do': './install.py' }
  Plug 'w0rp/ale'
endif

call plug#end()

filetype indent on
filetype plugin on

" ----------------------------------------------------------------------------
"  General settings {{{1
" ----------------------------------------------------------------------------
let mapleader = "\<space>" " Use space as leader key

" Use ; to enter command mode instead of :
nnoremap ; :
vnoremap ; :

" Re-center as you go through search results
map n  nzz
map N  Nzz
map *  *zz

" Change cwd to current file
map <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Hide other windows (:only, :on)
map <Leader>o :only<CR>

" Use +/- in normal mode to increment/decrement number
nmap <silent> + <C-a>
nmap <silent> - <C-x>

" Yank, delete, and paste
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" In terminal mode, use Esc to exit back to normal mode
" Disabled so that Esc closes FZF window
" tnoremap <Esc> <C-\><C-n>

" Re-select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting in visual mode
xnoremap <Tab> >gv|
xnoremap <S-Tab> <gv
nnoremap > >>_
nnoremap < <<_

" Smart up and down
nnoremap <silent><Down> gj
nnoremap <silent><Up> gk

" WIP: Folding
" close all open folds apart from the one that the cursor is on
nnoremap <Leader>zz zMzv
" Better folding mnemonics: [o]pen, [c]lose, etc.
" open all folds
nnoremap <Leader>zo zR
" close all folds
nnoremap <Leader>zc zM
" move down to top of next fold
nnoremap <Leader>z<Down> zj
" move up to bottom of previous fold
nnoremap <Leader>z<Up> zk

" spf13 and SpaceVim-like bindings
nnoremap <silent> <Leader>q :q<CR>
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>fed :e $MYVIMRC<CR>
nnoremap <silent> <Leader>feR :source $MYVIMRC<CR>
nnoremap <silent> <Leader>s- :split<CR>
nnoremap <silent> <Leader>s<bar> :vsplit<CR>
nnoremap <silent> <Leader>tn :set invnumber<CR>

" Disable Ex mode
nnoremap Q <nop>

" Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" ----------------------------------------------------------------------------
"  Plugin settings {{{1
" ----------------------------------------------------------------------------
" Deoplete {{{2
let g:deoplete#enable_at_startup = 1

" Eclim {{{2
let g:EclimJavascriptValidate = 0
let g:EclimCompletionMethod = 'omnifunc'
let g:EclimLoggingDisabled = 1

" Markdown {{{2
let g:vmt_auto_update_on_save = 0
let g:markdown_fenced_languages = ['bash=sh', 'html', 'ruby']

" Nvim-miniyank {{{2
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <Leader>n <Plug>(miniyank-cycle)

" Powerline {{{2
" Add powerline fonts to the dictionary
let g:airline_powerline_fonts = 1

" ----------------------------------------------------------------------------
"  Important
" ----------------------------------------------------------------------------
" See :help clipboard

" ----------------------------------------------------------------------------
"  Moving around, searching and patterns {{{1
" ----------------------------------------------------------------------------
set ignorecase " Searches are case insensitive
set smartcase  " Unless they contain at least one capital letter
set mouse=a

" ----------------------------------------------------------------------------
"  Displaying text {{{1
" ----------------------------------------------------------------------------
set relativenumber " Show relative line numbers on other lines
set number         " Show absolute line number on current line

" ----------------------------------------------------------------------------
"  Syntax, highlighting and spelling {{{1
" ----------------------------------------------------------------------------
au BufNewFile,BufRead *.gradle,*.tpl set filetype=groovy
au BufNewFile,BufRead Berksfile,Guardfile,Vagrantfile set syntax=ruby
set background=dark
colorscheme base16-oceanicnext
if exists('+colorcolumn')
  set colorcolumn=120
endif
set hlsearch " Highlight matches of most recent search
set conceallevel=2

if exists('+termguicolors')
  set termguicolors
elseif exists('+guicolors')
  set guicolors
endif

" ----------------------------------------------------------------------------
"  Multiple windows {{{1
" ----------------------------------------------------------------------------
set hidden " Hide abandoned buffers instead of unloading (preserves undo history)

" ----------------------------------------------------------------------------
"  Messages and info {{{1
" ----------------------------------------------------------------------------
set noshowmode " Hide default mode display, since Airline displays it

" ----------------------------------------------------------------------------
"  Tabs and indenting {{{1
" ----------------------------------------------------------------------------
set tabstop=2    " Tab = 2 spaces
set shiftwidth=2 " Autoindent indents 2 spaces
set expandtab    " Replace tabs with spaces

" ----------------------------------------------------------------------------
"  Folding {{{1
" ----------------------------------------------------------------------------
if has('folding')
  set foldmethod=syntax
  set nofoldenable " Open all folds when opening a file
endif

" ----------------------------------------------------------------------------
"  The swap file {{{1
" ----------------------------------------------------------------------------
set nobackup      " No backup files
set noswapfile    " No swap files
set nowritebackup " No backup files while editing
