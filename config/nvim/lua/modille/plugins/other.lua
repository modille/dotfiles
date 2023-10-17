return {
  {
    'azabiong/vim-highlighter',
    init = function()
      vim.g.HiSet = 'f<CR>'    -- normal, visual
      vim.g.HiClear = 'f<BS>'  -- normal, visual
      vim.g.HiErase = 'f<C-L>' -- normal
      vim.g.HiFind = 'f<Tab>'  -- normal, visual
    end,
  },
  { 'brooth/far.vim' },
  {
    'dbeniamine/cheat.sh-vim',
    init = function()
      vim.g.CheatSheetFrameworks = {
        bash = { 'bash', 'sh', 'zsh' },
        javascript = { 'javascript', 'json', 'jsx', 'node' },
        ruby = { 'eruby', 'ruby' },
      }
    end,
  },
  {
    'editorconfig/editorconfig-vim',
    init = function()
      -- Ensure that this plugin works well with fugitive
      vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*' }
    end,
  },
  {
    'godlygeek/tabular', -- For aligning text
    keys = {
      { '<leader>a=', '<cmd>Tabularize /=<CR>',         mode = { 'n', 'v' } },
      { '<leader>a|', '<cmd>Tabularize /|<CR>',         mode = { 'n', 'v' } },
      { '<leader>a:', '<cmd>Tabularize /:\zs/l0l1<CR>', mode = { 'n', 'v' } },
    },
  },
  {
    'haya14busa/vim-asterisk',
    lazy = false,
    dependencies = { 'haya14busa/is.vim' },
    keys = {
      { '*',  '<Plug>(asterisk-z*)',  mode = '' },
      { 'g*', 'Plug>(asterisk-gz*)',  mode = '' },
      { '#',  '<Plug>(asterisk-z#)',  mode = '' },
      { 'g#', '<Plug>(asterisk-gz#)', mode = '' },
    },
  },
  { 'mechatroner/rainbow_csv' },
  { 'mzlogin/vim-markdown-toc' },
  { 'simnalamburt/vim-mundo' },
  { 'tpope/vim-abolish' },
  { 'tpope/vim-bundler' },
  { 'tpope/vim-commentary' },
  {
    'tpope/vim-dispatch',
    dependencies = { 'radenling/vim-dispatch-neovim' },
  },
  { 'tpope/vim-dotenv' },
  { 'tpope/vim-endwise' },
  {
    'tpope/vim-fugitive',
    lazy = false, -- for "review" git alias
    dependencies = { 'shumphrey/fugitive-gitlab.vim' },
    init = function()
      vim.g.fugitive_gitlab_domains = { 'https://gitlab.upmc.com', 'https://gitlab.com' }
    end,
    keys = {
      { '<Leader>gs', '<cmd>Git<CR>' },
      { '<Leader>gb', '<cmd>Git blame<CR>' },
      { '<Leader>gl', '<cmd>Gclog<CR>' },
    },
  },
  { 'tpope/vim-projectionist' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-rhubarb' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-unimpaired' },
  {
    'stevearc/oil.nvim',
    lazy = false, -- so that it works with "nvim ./directory"
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    keys = {
      {
        '-',
        function()
          require('oil').open()
        end,
      },
    },
  },
  { 'tweekmonster/startuptime.vim' },
  {
    'vimwiki/vimwiki',
    init = function()
      vim.cmd(
        [[ let g:vimwiki_list = [{ 'path': '~/Library/CloudStorage/Dropbox/vimwiki/', 'syntax': 'markdown', 'ext': 'md', 'auto_diary_index': 1 }] ]]
      )
      vim.g.vimwiki_global_ext = 0
      vim.g.vimwiki_hl_cb_checked = 1
      vim.g.vimwiki_auto_header = 1
      vim.g.vimwiki_key_mappings = {
        -- header mapping (-) conflicts with tpope/vim-vinegar
        headers = 0,
      }
      -- remove tab-related mappings
      vim.cmd([[ nmap <Nop> <Plug>VimwikiTabIndex ]])
      vim.cmd([[ nmap <Nop> <Plug>VimwikiTabMakeDiaryNote ]])
    end,
  },
  {
    'will/bgwinch.nvim',
    config = false,
    commit = 'cafe0e1f2fb55bdd4ae515a3eca34d72e2dd5e99', -- Pinned because I don't trust will, lol
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  {
    'gbprod/yanky.nvim',
    lazy = false,
    config = true,
    keys = {
      { 'p',          '<Plug>(YankyPutAfter)',    mode = { 'n', 'x' } },
      { 'P',          '<Plug>(YankyPutBefore)',   mode = { 'n', 'x' } },
      { '<leader>mc', '<Plug>(YankyCycleForward)' },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add = { hl = 'GitSignsAdd', text = '┃', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change = { hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true })

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk)
        map('n', '<leader>hr', gs.reset_hunk)
        map('v', '<leader>hs', function()
          gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)
        map('v', '<leader>hr', function()
          gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function()
          gs.blame_line({ full = true })
        end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function()
          gs.diffthis('~')
        end)
        -- map('n', '<leader>td', gs.toggle_deleted)

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end,
    },
  },
  { 'norcalli/nvim-colorizer.lua' },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = {
        char = '▏',
      },
    },
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end,
  },
  { 'MunifTanjim/nui.nvim',         lazy = true },
  { 'bennypowers/nvim-regexplainer' },
  {
    'karb94/neoscroll.nvim',
    enabled = false,
    opts = {
      -- All these keys will be mapped to their corresponding default scrolling animation
      -- mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zz', 'zb' },
      hide_cursor = false,         -- Hide cursor while scrolling
      stop_eof = true,             -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = nil,       -- Default easing function
      pre_hook = nil,              -- Function to run before the scrolling animation starts
      post_hook = nil,             -- Function to run after the scrolling animation ends
      performance_mode = false,    -- Disable "Performance Mode" on all buffers.
    },
  },
  { 'sindrets/diffview.nvim' },
  {
    'aryklein/NoTrailing.nvim',
    commit = '05e82df91d75fc41d10f8df6cbc5fdcf762f1d36',
    cmd = { 'TrailingTrim', 'TrailingHighlightToggle' },
    opts = {
      highlight = 'ErrorMsg',
      exclude_filetypes = { 'Telescope', 'help', 'lazy', 'Trouble' },
    },
    init = function()
      require('NoTrailing').highlight()
    end,
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      enable_builtin = true, -- shows a list of builtin actions when no action is provided
      timeline_marker = '└',
    },
    keys = {
      { '<leader>O', '<cmd>Octo<cr>' },
    },
  },
}
