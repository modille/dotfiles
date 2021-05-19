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
  silent !curl -fLo ~/git/github.com/modille/dotfiles/tag-vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

call plug#begin('~/git/github.com/modille/dotfiles/tag-vim/plugged')

" Colorschemes {{{2
" Plug 'chriskempson/base16-vim'
" Plug 'jez/vim-colors-solarized' " Improved solarized highlighting

" Language support {{{2
Plug 'briancollins/vim-jst',             { 'for': 'ejs' }
Plug 'cespare/vim-toml',                 { 'for': 'toml' }
Plug 'craigdallimore/vim-jest-cli',      { 'for': 'javascript' }
Plug 'docker/docker',                    { 'for': 'dockerfile', 'rtp': 'contrib/syntax/vim' }
Plug 'elzr/vim-json'
Plug 'fatih/vim-go',                     { 'for': ['asm', 'go', 'gohtmltmpl'] }
Plug 'heavenshell/vim-jsdoc',            { 'for': ['javascript', 'javascript.jsx','typescript'], 'do': 'make install' }
Plug 'modille/groovy.vim',               { 'for': 'groovy' }
Plug 'modille/vim-search-maven',         { 'for': 'groovy', 'branch': 'gradle' }
Plug 'mustache/vim-mustache-handlebars', { 'for': 'mustache' }
Plug 'mxw/vim-jsx',                      { 'for': ['javascript', 'jsx'] }
Plug 'mzlogin/vim-markdown-toc',         { 'for': 'markdown' }
Plug 'nginx/nginx',                      { 'rtp': 'contrib/vim' }
Plug 'notriddle/vim-gitcommit-markdown'
Plug 'pangloss/vim-javascript',          { 'for': 'javascript' }
Plug 'tmux-plugins/vim-tmux',            { 'for': 'tmux' }
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'

" Text objects {{{2
Plug 'kana/vim-textobj-user' | Plug 'kana/vim-textobj-function' | Plug 'Julian/vim-textobj-variable-segment' | Plug 'glts/vim-textobj-comment' | Plug 'haya14busa/vim-textobj-function-syntax'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }
Plug 'vim-scripts/argtextobj.vim'

" Other plugins {{{2
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color' " Highlight colors in CSS files
" Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
Plug 'brooth/far.vim'
" Plug 'easymotion/vim-easymotion' | Plug 'haya14busa/vim-easyoperator-line' | Plug 'haya14busa/vim-easyoperator-phrase'
Plug 'editorconfig/editorconfig-vim'
" Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'gerw/vim-HiLinkTrace'
Plug 'godlygeek/tabular'
Plug 'haya14busa/is.vim'
Plug 'haya14busa/vim-asterisk'
Plug 'janko-m/vim-test'
Plug 'jpalardy/spacehi.vim'
Plug 'kshenoy/vim-signature' " Show marks in gutter
Plug 'liuchengxu/vista.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'machakann/vim-swap'
" Plug 'mattn/emmet-vim'
Plug 'mhinz/vim-startify'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'peterrincker/vim-argumentative'
Plug 'rizzatti/dash.vim'
Plug 'shougo/echodoc.vim'
Plug 'shougo/vimproc.vim', { 'do': 'make' }
Plug 'simnalamburt/vim-mundo'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dadbod' | Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'tpope/vim-dispatch' | Plug 'radenling/vim-dispatch-neovim'
Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive' | Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-vinegar'
Plug 'tweekmonster/startuptime.vim'
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-session'

" FZF
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } | Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'

" Neovim-only plugins {{{2
if has('nvim')
  " http://vim.wikia.com/wiki/Replace_a_word_with_yanked_text
  " Consider yi" then ci"<C-R>0 then . to repeat
  Plug 'bfredl/nvim-miniyank'
  Plug 'kassio/neoterm'
  " Plug 'osyo-manga/vim-brightest' " Highlight word under cursor
  Plug 'dense-analysis/ale'

  " Snippets
  Plug 'sirver/ultisnips'
  Plug 'honza/vim-snippets'
  Plug 'modille/vim-jest-snippets'

  " CoC intellisense engine
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Deoplete
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  " Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
  " Plug 'zchee/deoplete-docker'

  " 0.5.0
  " Plug 'shougo/deoplete-lsp'
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'ojroques/nvim-lspfuzzy'
  Plug 'hrsh7th/nvim-compe'
  Plug 'hrsh7th/vim-vsnip' | Plug 'hrsh7th/vim-vsnip-integ' | Plug 'rafamadriz/friendly-snippets'
  " Plug 'nvim-telescope/telescope.nvim' | Plug 'nvim-lua/popup.nvim' | Plug 'nvim-lua/plenary.nvim'
  Plug 'ishan9299/nvim-solarized-lua' " https://www.reddit.com/r/neovim/comments/mgzbj6/i_will_pay_50_to_whoever_updates_solarized_to_be/
  Plug 'kosayoda/nvim-lightbulb'
endif

call plug#end()

if has('nvim')
  " Disable Python2 check since it's EOL
  let g:loaded_python2_provider = 0

  " Use python3 binary from Homebrew
  let g:python3_host_prog = '/usr/local/bin/python3'

  " To use an absolute path (e.g. to an rbenv installation): >
  let g:ruby_host_prog = '~/.rbenv/versions/2.5.8/bin/neovim-ruby-host'
endif

filetype indent on
filetype plugin on

" ----------------------------------------------------------------------------
"  General settings {{{1
" ----------------------------------------------------------------------------
let g:mapleader = "\<space>"

" Use ; to enter command mode instead of :
nnoremap ; :
vnoremap ; :

" Change cwd to current file
map <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Hide other windows (:only, :on)
map <Leader>o :only<CR>

" Yank, delete, and paste
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Copy current file name (relative/absolute) to system clipboard
" relative path  (src/foo.txt)
nnoremap <leader>cf :let @*=expand("%")<CR>
" absolute path  (/something/src/foo.txt)
nnoremap <leader>cF :let @*=expand("%:p")<CR>
" filename       (foo.txt)
nnoremap <leader>ct :let @*=expand("%:t")<CR>
" directory name (/something/src)
nnoremap <leader>ch :let @*=expand("%:p:h")<CR>

" In terminal mode, use Esc to exit back to normal mode
" Disabled so that Esc closes FZF window
" tnoremap <Esc> <C-\><C-n>

" Re-select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting in visual mode
" xnoremap <Tab> >gv|
" xnoremap <S-Tab> <gv
nnoremap > >>_
nnoremap < <<_

" Smart up and down
" nnoremap <silent><Down> gj
" nnoremap <silent><Up> gk

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
nnoremap <silent> <Leader>cc :cclose<CR>
nnoremap <silent> <Leader>co :copen<CR>
nnoremap <silent> <Leader>lc :lclose<CR>
nnoremap <silent> <Leader>lo :lopen<CR>
nnoremap <silent> <Leader>q :q<CR>
nnoremap <silent> <Leader>w :w<CR>
nnoremap <silent> <Leader>fed :e $MYVIMRC<CR>
nnoremap <silent> <Leader>feR :source $MYVIMRC<CR>

" Disable Ex mode
nnoremap Q <nop>

" Clear current search highlight by double tapping //
nmap <silent> // :nohlsearch<CR>

" Easier split navigations
nnoremap <C-Down> <C-W><C-J>
nnoremap <C-Up> <C-W><C-K>
nnoremap <C-Right> <C-W><C-L>
nnoremap <C-Left> <C-W><C-H>
if has('nvim')
  tnoremap <C-Down> <C-\><C-n><C-w><C-j>
  tnoremap <C-Up> <C-\><C-n><C-w><C-k>
  tnoremap <C-Right> <C-\><C-n><C-w><C-l>
  tnoremap <C-Left> <C-\><C-n><C-w><C-h>
endif

" Avoid accidental S-Up and S-Down when in V-LINE mode
nmap <S-Up> <Up>
nmap <S-Down> <Down>
vmap <S-Up> <Up>
vmap <S-Down> <Down>

if has('nvim')
  " Easier escape in terminal
  tnoremap <Esc> <C-\><C-n>

  " ...but still be able to send an Escape key
  " Mnemonic: Verbatim escape (similar to :help i_ctrl-v)
  tnoremap <C-v><Esc> <Esc>

  " Commands
  nnoremap <silent> <Leader>nrb :1T npm run build<CR>
  nnoremap <silent> <Leader>nrl :1T npm run lint<CR>
  nnoremap <silent> <Leader>nrt :1T npm run test<CR>
endif

" Lots of alternatives methods at
" http://vim.wikia.com/wiki/Open_a_web-browser_with_the_URL_in_the_current_line
" gx is similar
function! SearchVisualDockerHubOpen() "{{{2
  " Get search string from visual selection
  let l:tmp = @"
  execute 'normal! vgvy'
  let l:result = @"
  let @" = l:tmp

  " 1. split the search string in seperate words
  " 2. join the words seperated by +
  " 3. replace all " with an empty string
  let l:term = substitute(join(split(l:result),'+'),'"','','g')

  let l:dockerhub = 'https://hub.docker.com/search/?isAutomated=0&isOfficial=0&page=1&pullCount=0&starCount=0&q='
  let l:query = l:dockerhub . l:term

  let l:browser_cmd = 'open'

  execute 'silent !' . l:browser_cmd . ' "' . l:query . '"'
endfunction

nnoremap tc :tabclose<CR>
nnoremap tn :tabnext<CR>
nnoremap tp :tabprev<CR>

" ----------------------------------------------------------------------------
"  Plugin settings {{{1
" ----------------------------------------------------------------------------
" ALE {{{2
let g:ale_disable_lsp = 1

" Cucumber {{{2
let g:cucumber_steps_glob = '/features/**/*.{js,rb} /green_hill/step_definitions/**/*.{js,rb}'

" Eclim {{{2
let g:EclimJavascriptValidate = 0
let g:EclimCompletionMethod = 'omnifunc'
let g:EclimLoggingDisabled = 1

" gitgutter {{{2
let g:gitgutter_sign_added              = '+'
let g:gitgutter_sign_modified           = '~'
let g:gitgutter_sign_removed            = '-'
let g:gitgutter_sign_removed_first_line = '‾'
let g:gitgutter_sign_modified_removed   = '≃'

" javascript {{{2
let g:javascript_plugin_jsdoc = 1

" Markdown {{{2
let g:vmt_auto_update_on_save = 0
let g:markdown_composer_open_browser = 0
let g:markdown_fenced_languages = ['bash=sh', 'html', 'ruby']

" netrw {{{2
let g:netrw_altfile=1

" Powerline {{{2
let g:airline_powerline_fonts = 0

" LanguageClient
" let g:LanguageClient_serverCommands = {
"     \ 'dockerfile': ['/usr/local/bin/docker-langserver', '--stdio']
"     \ }
" let g:LanguageClient_autoStart = 1

" 0.5.0
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true
  }
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.bashls.setup {}
require'lspconfig'.dockerls.setup {}
require'lspconfig'.solargraph.setup {
 capabilities = capabilities,
}
require'lspconfig'.tsserver.setup{
 capabilities = capabilities,
}

vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    tags = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

vim.g.solarized_italics = 1

-- nvim-lightbulb
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
EOF

" https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
lua << EOF
local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    --buf_set_keymap("v", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    buf_set_keymap("v", "<space>ff", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=238 guibg=#eee8d5
      hi LspReferenceText cterm=bold ctermbg=238 guibg=#eee8d5
      hi LspReferenceWrite cterm=bold ctermbg=238 guibg=#eee8d5
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

-- Use a loop to conveniently both setup defined servers
-- and map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end
EOF

" " Expand
" imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
" smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" " Jump forward or backward
" imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
" smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" let g:deoplete#enable_at_startup = 1
" " Find files using Telescope command-line sugar.
" nnoremap <leader>fs <cmd>Telescope find_files<cr>
" nnoremap <leader>fg <cmd>Telescope live_grep<cr>
" nnoremap <leader>bs <cmd>Telescope buffers<cr>
" nnoremap <leader>fh <cmd>Telescope oldfiles<cr>

" The following sections are organized similar to :options

" ----------------------------------------------------------------------------
"  2 moving around, searching and patterns {{{1
" ----------------------------------------------------------------------------
set ignorecase
set smartcase

" ----------------------------------------------------------------------------
"  4 displaying text {{{1
" ----------------------------------------------------------------------------
set number

" ----------------------------------------------------------------------------
"  5 syntax, highlighting and spelling {{{1
" ----------------------------------------------------------------------------
set background=light
set hlsearch
if exists('&inccommand')
  set inccommand=nosplit
endif

if exists('+termguicolors')
  set termguicolors
endif

if exists('+colorcolumn')
  set colorcolumn=80
endif

colorscheme solarized
" colorscheme base16-solarized-light
let g:airline_theme='solarized'

" Italicised highlight groups
" You can see all the groups currently active with this command:
"   :so $VIMRUNTIME/syntax/hitest.vim
" https://vim.fandom.com/wiki/Identify_the_syntax_highlighting_group_used_at_the_cursor
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
highlight Comment cterm=italic gui=italic
highlight cucumberBackground cterm=italic gui=italic ctermfg=5 guifg=#6c71c4
highlight cucumberFeature cterm=italic gui=italic ctermfg=1 guifg=#dc322f
highlight cucumberGiven cterm=italic gui=italic ctermfg=5 guifg=#6c71c4
highlight cucumberScenario cterm=italic gui=italic ctermfg=5 guifg=#6c71c4
highlight cucumberScenarioOutline cterm=italic gui=italic ctermfg=5 guifg=#6c71c4
highlight cucumberThen cterm=italic gui=italic ctermfg=3 guifg=#b58900
highlight cucumberWhen cterm=italic gui=italic ctermfg=4 guifg=#268bd2
highlight htmlArg cterm=italic gui=italic
highlight rubyConstant cterm=italic gui=italic

let ruby_spellcheck_strings = 1

" ----------------------------------------------------------------------------
"  6 multiple windows {{{1
" ----------------------------------------------------------------------------
set previewheight=28
set hidden " Preserves undo history
set splitbelow
set splitright

" ----------------------------------------------------------------------------
"  11 messages and info {{{1
" ----------------------------------------------------------------------------
set noshowmode " Airline displays it for us

" ----------------------------------------------------------------------------
"  12 selecting text {{{1
" ----------------------------------------------------------------------------
" See :help clipboard

" ----------------------------------------------------------------------------
"  13 editing text {{{1
" ----------------------------------------------------------------------------
" Enable persistent undo so that undo history persists across vim sessions
set undofile
set undodir=~/.local/share/nvim/undo
set dictionary=/usr/share/dict/words

" ----------------------------------------------------------------------------
"  14 tabs and indenting {{{1
" ----------------------------------------------------------------------------
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" ----------------------------------------------------------------------------
"  15 folding {{{1
" ----------------------------------------------------------------------------
if has('folding')
  set foldmethod=indent " https://github.com/dense-analysis/ale/issues/1829
  set nofoldenable
endif

" ----------------------------------------------------------------------------
"  18 reading and writing files {{{1
" ----------------------------------------------------------------------------
set nowritebackup
set nobackup
set autoread

" ----------------------------------------------------------------------------
"  19 the swap file {{{1
" ----------------------------------------------------------------------------
set noswapfile
set updatetime=100
