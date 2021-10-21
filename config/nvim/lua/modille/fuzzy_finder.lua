local actions = require('telescope.actions')
local builtin = require('telescope.builtin')

-- https://github.com/nvim-telescope/telescope.nvim
require('telescope').setup {
  defaults = {
    prompt_prefix = '> ',
    selection_caret = '  ',
    entry_prefix = '  ',
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil
    mappings = {
      i = {
        ['<C-x>'] = false,
        ['<C-q>'] = actions.send_to_qflist,
      },
    }
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = 'smart_case',        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    dash = {
      -- map filetype strings to the keywords you've configured for docsets in Dash
      -- setting to false will disable filtering by filetype for that filetype
      -- filetypes not included in this table will not filter the query by filetype
      -- check lua/dash/utils/config.lua to see all defaults
      -- the values you pass for file_type_keywords are merged with the defaults
      -- to disable filtering for all filetypes,
      -- set file_type_keywords = false
      file_type_keywords = {
        javascript = { 'js', 'javascript', 'nodejs' },
        eruby = { 'rb', 'rubygems', 'gem', 'rails', 'ruby'  },
        ruby = { 'rb', 'rubygems', 'gem', 'rails', 'ruby'  },
      },
    },
  },
}

-- https://github.com/nvim-telescope/telescope-dap.nvim
require('telescope').load_extension('dap')

-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
require('telescope').load_extension('fzf')

-- https://github.com/Kapeli/dash.nvim
require('telescope').load_extension('dash')

local function file_search_dotfiles()
  builtin.find_files({
    prompt_title = 'dotfiles >',
    cwd = os.getenv('HOME') .. '/git/github.com/modille/dotfiles',
    hidden = false,
  })
end

local function file_grep_dotfiles()
  builtin.grep_string({
    search = vim.fn.input("dotfiles 🔍 "),
    cwd = os.getenv('HOME') .. '/git/github.com/modille/dotfiles',
    hidden = false,
  })
end

return {
  file_search_dotfiles = file_search_dotfiles,
  file_grep_dotfiles = file_grep_dotfiles,
}
