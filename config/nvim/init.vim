" vim:fdm=marker
" vimrc

" ----------------------------------------------------------------------------
"  Vim package manager {{{1
" ----------------------------------------------------------------------------
" Setup {{{2
if has('vim_starting')
  set runtimepath+=~/dotfiles/tag-vim/
endif

" Auto-install vim-plug
if empty(glob('~/dotfiles/tag-vim/autoload/plug.vim'))
  silent !mkdir -p ~/dotfiles/tag-vim/autoload
  silent !curl -fLo ~/dotfiles/tag-vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/dotfiles/tag-vim/plugged')

" Colorschemes {{{2
Plug 'chriskempson/base16-vim'
Plug 'marciomazza/vim-brogrammer-theme'
Plug 'sickill/vim-monokai'
Plug 'sjl/badwolf'
Plug 'tomasr/molokai'
Plug 'nanotech/jellybeans.vim'

" Language support {{{2
Plug 'PProvost/vim-ps1',              { 'for': 'ps1' }
Plug 'cespare/vim-toml',              { 'for': 'toml' }
Plug 'elixir-lang/vim-elixir',        { 'for': ['eelixer', 'elixer'] }
Plug 'fatih/vim-go',                  { 'for': ['asm', 'go', 'gohtmltmpl'] }
Plug 'modille/groovy.vim',            { 'for': 'groovy' }
Plug 'nginx/nginx',                   { 'rtp': 'contrib/vim' }
Plug 'nikolavp/vim-jape',             { 'for': 'jape' }
Plug 'tmux-plugins/vim-tmux',         { 'for': 'tmux' }
Plug 'tpope/vim-rails'
Plug 'wavded/vim-stylus',             { 'for': 'stylus' }
Plug 'wting/rust.vim',                { 'for': 'rust' }

" Other plugins {{{2
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color' " Highlight colors in CSS files
Plug 'bronson/vim-trailing-whitespace'
Plug 'easymotion/vim-easymotion'
Plug 'godlygeek/tabular'
Plug 'heavenshell/vim-jsdoc'
Plug 'jpalardy/spacehi.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kshenoy/vim-signature' " Show bookmarks in gutter
Plug 'mhinz/vim-startify'
Plug 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesToggle' }
Plug 'rizzatti/dash.vim'
Plug 'schickling/vim-bufonly'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeFind', 'NERDTreeToggle'] }
Plug 'shougo/vimproc.vim', { 'do': 'make' }
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-misc' " Required for vim-session
Plug 'xolox/vim-session'
Plug 'xuyuanp/nerdtree-git-plugin'

" Neovim-only plugins {{{2
if has('nvim')
  Plug 'benekastah/neomake'
  Plug 'bfredl/nvim-miniyank'
  Plug 'kassio/neoterm'
  Plug 'osyo-manga/vim-brightest' " Highlight word under cursor
  Plug 'sirver/ultisnips' | Plug 'honza/vim-snippets'
  Plug 'valloric/YouCompleteMe', { 'do': './install.py' }
endif

call plug#end()

filetype plugin indent on

" ----------------------------------------------------------------------------
"  General settings {{{1
" ----------------------------------------------------------------------------
let mapleader = ',' " Use comma as leader key

" Use ; to enter command mode instead of :
nnoremap ; :
vnoremap ; :

" Re-center as you go through search results
map n  nzz
map N  Nzz
map *  *zz

" Change cwd to current file
map <Leader>cd :cd %:p:h<CR>

" Format XML files
map <Leader>fx !%xmllint --format --recover -

" Hide other windows (:only, :on)
map <Leader>o :only<CR>

" Use +/- in normal mode to increment/decrement number
nmap <silent> + <C-a>
nmap <silent> - <C-x>

" In visual mode, use Y to copy to system clipboard
vnoremap Y "*y

" In terminal mode, use Esc to exit back to normal mode
tnoremap <Esc> <C-\><C-n>

" ----------------------------------------------------------------------------
"  Plugin settings {{{1
" ----------------------------------------------------------------------------
" Airline {{{2
let g:airline#extensions#hunks#enabled=0
let g:airline_powerline_fonts = 1 "Add powerline fonts to the dictionary
let g:airline_section_z = '%3c'
let g:airline_theme = 'badwolf' "jellybeans, lucius, raven, term
let g:bufferline_echo = 0

" Dash {{{2
nmap <silent> <Leader>d <Plug>DashSearch
let g:dash_map = {
  \ 'groovy': ['groovy', 'grails', 'spring', 'java', 'javafx', 'javadoc'],
  \ 'ruby':   ['chef', 'ruby', 'rubygems', 'rails']
  \ }

" Eclim {{{2
let g:EclimJavascriptValidate = 0

" EasyMotion {{{2
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
nmap s <Plug>(easymotion-overwin-f)
" nmap s <Plug>(easymotion-overwin-f2)

" Fugitive {{{2
let g:fugitive_gitlab_domains = ['https://gitlab.com']

" FZF {{{2
let g:fzf_action = {
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up.
let g:fzf_history_dir = '~/.fzf-history'
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>g :Ag<CR>
nnoremap <silent> <Leader>r :Files<CR>

" Indent Guides {{{2
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" Marks {{{2
nmap <silent> <Leader>st :SignatureToggle<CR>

" NeoMake {{{2
let g:neomake_error_sign = { 'texthl': 'ErrorMsg' }
let g:neomake_warning_sign = { 'texthl': 'WarningMsg' }
let g:neomake_javascript_enabled_makers = ['jscs', 'jshint']
let g:neomake_ruby_rubocop_maker = {
  \ 'args': ['--require', 'cookstyle']
  \ }
let g:neomake_ruby_enabled_makers = ['mri', 'rubocop']

" Neoterm {{{2
let g:neoterm_rspec_lib_cmd = 'rspec --color --format doc'
nnoremap <silent> <Leader>ta :call neoterm#test#run('all')<cr>
nnoremap <silent> <Leader>tf :call neoterm#test#run('file')<cr>
nnoremap <silent> <Leader>tc :call neoterm#test#run('current')<cr>
nnoremap <silent> <Leader>tr :call neoterm#test#rerun()<cr>
nnoremap <silent> <Leader>to :call neoterm#open()<cr>
nnoremap <silent> <Leader>tq :call neoterm#close()<cr>
nnoremap <silent> <Leader>tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
nnoremap <silent> <Leader>tx :call neoterm#kill()<cr>

" Nerdtree {{{2
nmap <silent> <Leader>nt :NERDTreeToggle<CR>
nmap <silent> <Leader>nc :NERDTreeCWD<CR>
nmap <silent> <Leader>nf :NERDTreeFind<CR>

" Nvim-miniyank {{{2
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)
map <leader>n <Plug>(miniyank-cycle)

" Session {{{2
let g:session_autosave = 'yes'
let g:session_autosave_periodic = 1
let g:session_autosave_silent = 1
let g:session_default_to_last = 1
let g:session_autoload = 'no'

" Startify {{{2
let g:startify_change_to_vcs_root = 1
let g:startify_session_dir = '~/.vim/sessions'

" Syntastic {{{2
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_javascript_checkers = ['jscs', 'jshint']

" Tabular {{{2
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs/l0l1<CR>
vmap <Leader>a: :Tabularize /:\zs/l0l1<CR>

" Ultisnips {{{2
" let g:UltiSnipsSnippetDirectories=['Ultisnips', 'custom_snippets']
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" YouCompleteMe {{{2
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_semantic_triggers = { 'groovy': ['.'] }
let g:EclimCompletionMethod = 'omnifunc'
" Preview window seems broken at the moment, so...
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

" ----------------------------------------------------------------------------
"  Important
" ----------------------------------------------------------------------------
set nopaste " TODO: instead try: set clipboard+=unnamedplus (help nvim_clipboard)

" ----------------------------------------------------------------------------
"  Moving around, searching and patterns {{{1
" ----------------------------------------------------------------------------
set ignorecase " Searches are case insensitive
set smartcase  " Unless they contain at least one capital letter

" ----------------------------------------------------------------------------
"  Displaying text {{{1
" ----------------------------------------------------------------------------
set number " Show line numbers

" ----------------------------------------------------------------------------
"  Syntax, highlighting and spelling {{{1
" ----------------------------------------------------------------------------
au BufNewFile,BufRead *.gradle,*.tpl set filetype=groovy
au BufNewFile,BufRead *.md set syntax=markdown
au BufNewFile,BufRead Berksfile,Guardfile,Vagrantfile set syntax=ruby
set background=dark
colorscheme badwolf
if exists('+colorcolumn')
  set colorcolumn=120
endif
set hlsearch " Highlight matches of most recent search

" ----------------------------------------------------------------------------
"  Multiple windows {{{1
" ----------------------------------------------------------------------------
set hidden       " Hide abandoned buffers instead of unloading (preserves undo history)

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

" ----------------------------------------------------------------------------
"  Autocmds {{{1
" ----------------------------------------------------------------------------
autocmd FileType gitcommit setlocal spell spelllang=en_us " Spellcheck commit messages

" Highlight tabs and trailing whitespaces
autocmd syntax * SpaceHi

" Run Neomake on open and after write
augroup neomake
  autocmd! BufReadPost * Neomake
  autocmd! BufWritePost * Neomake
augroup END
