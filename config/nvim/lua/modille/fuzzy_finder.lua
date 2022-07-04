local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

-- https://github.com/nvim-telescope/telescope.nvim
require('telescope').setup({
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
})

-- https://github.com/nvim-telescope/telescope-dap.nvim
-- require('telescope').load_extension('dap')

-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
require('telescope').load_extension('fzf')

local function file_search_dotfiles()
  builtin.find_files({
    prompt_title = 'dotfiles >',
    cwd = os.getenv('HOME') .. '/git/github.com/modille/dotfiles',
    hidden = false,
  })
end

local function file_grep_dotfiles()
  builtin.grep_string({
    search = vim.fn.input('dotfiles 🔍 '),
    cwd = os.getenv('HOME') .. '/git/github.com/modille/dotfiles',
    hidden = false,
  })
end

-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
local function project_files()
  local opts = {} -- define here if you want to define something
  local ok = pcall(builtin.git_files, opts)
  if not ok then
    builtin.find_files(opts)
  end
end

return {
  file_search_dotfiles = file_search_dotfiles,
  file_grep_dotfiles = file_grep_dotfiles,
  project_files = project_files,
}
