return {
  { 'blankname/vim-fish', ft = 'fish' },
  { 'briancollins/vim-jst', ft = 'ejs' },
  { 'cespare/vim-toml', ft = 'toml' },
  { 'craigdallimore/vim-jest-cli', ft = 'javascript' },
  { 'fatih/vim-go', ft = { 'asm', 'go', 'gohtmltmpl' } },
  {
    'jgdavey/vim-blockle',
    ft = 'ruby',
    init = function()
      vim.g.blockle_mapping = '<Leader>bt'
    end,
  },
  { 'modille/groovy.vim', ft = 'groovy' },
  { 'modille/vim-search-maven', ft = 'groovy', branch = 'gradle' },
  { 'mustache/vim-mustache-handlebars', ft = 'mustache' },
  {
    'maxmellon/vim-jsx-pretty',
    ft = 'javascript',
    init = function()
      vim.g.vim_jsx_pretty_colorful_config = 1
    end,
  },
  {
    'nginx/nginx',
    event = 'VeryLazy',
    config = function(plugin)
      vim.opt.rtp:append(plugin.dir .. '/contrib/vim')
    end,
  },
  {
    'pangloss/vim-javascript',
    ft = 'javascript',
    init = function()
      -- Enable syntax highlighting for JSDocs
      vim.g.javascript_plugin_jsdoc = 1
    end,
  },
  { 'tmux-plugins/vim-tmux', ft = 'tmux' },
  {
    'tpope/vim-markdown',
    ft = 'markdown',
    init = function()
      -- https://github.com/tpope/vim-markdown/pull/135
      vim.g.markdown_folding = 1
    end,
  },
  { 'elzr/vim-json', event = 'VeryLazy' },
  { 'notriddle/vim-gitcommit-markdown', event = 'VeryLazy' },
  { 'towolf/vim-helm', event = 'VeryLazy' },
  { 'tpope/vim-cucumber', event = 'VeryLazy' },
  { 'tpope/vim-rails', event = 'VeryLazy' },
}
