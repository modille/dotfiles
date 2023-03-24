return {
  { 'nvim-lua/popup.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    cmd = 'Telescope',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzf-native.nvim' },
    opts = function()
      local actions = require('telescope.actions')
      return {
        defaults = {
          prompt_prefix = '> ',
          selection_caret = '  ',
          entry_prefix = '  ',
          color_devicons = true,
          set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil
          file_ignore_patterns = {
            '%.har$',
          },
          mappings = {
            i = {
              -- ['<esc>'] = actions.close, -- should try getting used to C-c instead, so you don't lose Normal mode features
              ['<C-p>'] = actions.cycle_history_prev,
              ['<C-n>'] = actions.cycle_history_next,
            },
          },
          cache_picker = {
            num_pickers = 20,
          },
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden', -- Include hidden files
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case', -- or 'ignore_case' or 'respect_case'
          },
        },
      }
    end,
    config = function(_, opts)
      require('telescope').setup(opts)

      -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
      require('telescope').load_extension('fzf')
    end,
    keys = {
      {
        '<leader>fg',
        function()
          require('telescope.builtin').grep_string({ search = vim.fn.input('🔍 ') })
        end,
        mode = { 'n' },
        desc = 'file grep',
      },
      {
        '<leader>fg',
        function()
          local buf_vtext = function()
            local a_orig = vim.fn.getreg('a')
            local mode = vim.fn.mode()
            if mode ~= 'v' and mode ~= 'V' then
              vim.cmd([[normal! gv]])
            end
            vim.cmd([[normal! "aygv]])
            local text = vim.fn.getreg('a')
            vim.fn.setreg('a', a_orig)
            return text
          end

          require('telescope.builtin').grep_string({ search = buf_vtext() })
        end,
        mode = { 'v' },
        desc = 'file grep visual selection',
      },
      {
        '<leader>fos',
        '<cmd>Telescope oldfiles<cr>',
        desc = 'file old select',
      },
      {
        '<leader>fs',
        function()
          local builtin = require('telescope.builtin')
          local opts = {} -- define here if you want to define something
          local ok = pcall(builtin.git_files, opts)
          if not ok then
            builtin.find_files(opts)
          end
        end,
        desc = 'file select',
      },
      {
        '<leader>bs',
        function()
          require('telescope.builtin').buffers({ previewer = false, sort_lastused = true })
        end,
        desc = 'buffer select',
      },
      {
        '<leader>fds',
        function()
          require('telescope.builtin').find_files({
            prompt_title = 'dotfiles >',
            cwd = os.getenv('HOME') .. '/git/github.com/modille/dotfiles',
            hidden = false,
          })
        end,
        desc = 'file dotfiles select',
      },
      {
        '<leader>fdg',
        function()
          require('telescope.builtin').grep_string({
            search = vim.fn.input('dotfiles 🔍 '),
            cwd = os.getenv('HOME') .. '/git/github.com/modille/dotfiles',
            hidden = false,
          })
        end,
        desc = 'file dotfiles grep',
      },
      {
        '<leader>fws',
        function()
          require('telescope.builtin').find_files({
            prompt_title = 'wiki >',
            cwd = os.getenv('HOME') .. '/Dropbox/vimwiki',
            hidden = false,
          })
        end,
        desc = 'file wiki select',
      },
      {
        '<leader>fwg',
        function()
          require('telescope.builtin').grep_string({
            search = vim.fn.input('wiki 🔍 '),
            cwd = os.getenv('HOME') .. '/Dropbox/vimwiki',
            hidden = false,
          })
        end,
        desc = 'file wiki grep',
      },
    },
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  { 'Kapeli/dash.nvim' },
}
