return {
  -- https://github.com/nvim-treesitter/nvim-treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      ensure_installed = {
        'c',
        'bash',
        'css',
        'dockerfile',
        'fish',
        'go',
        'graphql',
        'html',
        'http',
        'java',
        'javascript',
        'jsdoc',
        'json',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'ruby',
        'rust',
        'scss',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc', -- fka 'help' https://github.com/nvim-treesitter/nvim-treesitter/issues/2293#issuecomment-1492982270
        'yaml',
      },
      highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
      -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
      context_commentstring = {
        enable = true,
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      function _G.javascript_indent()
        local line = vim.fn.getline(vim.v.lnum)
        local prev_line = vim.fn.getline(vim.v.lnum - 1)
        if line:match('^%s*[%*/]%s*') then
          if prev_line:match('^%s*%*%s*') then
            return vim.fn.indent(vim.v.lnum - 1)
          end
          if prev_line:match('^%s*/%*%*%s*$') then
            return vim.fn.indent(vim.v.lnum - 1) + 1
          end
        end

        return vim.fn['GetJavascriptIndent']()
      end

      vim.cmd([[autocmd FileType javascript setlocal indentexpr=v:lua.javascript_indent()]])
    end,
    dependencies = {
      'nvim-treesitter/playground',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'ThePrimeagen/refactoring.nvim',
      'code-biscuits/nvim-biscuits',
    },
  },
  {
    'danymat/neogen',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
  },

  -- https://github.com/code-biscuits/nvim-biscuits#configuration
  {
    'code-biscuits/nvim-biscuits',
    opts = {
      toggle_keybind = '<leader>cb',
      show_on_start = false,
      default_config = {
        prefix_string = '🍪 ',
      },
    },
  },
}
