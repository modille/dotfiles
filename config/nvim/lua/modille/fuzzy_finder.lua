local actions = require('telescope.actions')

-- https://github.com/nvim-telescope/telescope.nvim
require('telescope').setup {
  defaults = {
    prompt_prefix = '> ',
    selection_caret = '  ',
    entry_prefix = '  ',
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil

    file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

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
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = 'smart_case',        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}

-- https://github.com/nvim-telescope/telescope-dap.nvim
require('telescope').load_extension('dap')

-- https://github.com/nvim-telescope/telescope-fzf-native.nvim
require('telescope').load_extension('fzf')

local function file_search_dotfiles()
  require('telescope.builtin').find_files({
    prompt_title = 'dotfiles >',
    cwd = os.getenv('HOME') .. '/git/github.com/modille/dotfiles',
    hidden = false,
  })
end

local function file_grep_dotfiles()
  require('telescope.builtin').grep_string({
    search = vim.fn.input("dotfiles 🔍 "),
    cwd = os.getenv('HOME') .. '/git/github.com/modille/dotfiles',
    hidden = false,
  })
end

return {
  file_search_dotfiles = file_search_dotfiles,
  file_grep_dotfiles = file_grep_dotfiles,
}
