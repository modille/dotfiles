---@type LazySpec
return {
  -- TODO: Try sidekick instead...
  -- require("plugins.ai.avante_nvim"),
  -- require("plugins.ai.copilot_lua"),

  require("plugins.coding.blink_cmp"),
  require("plugins.coding.diffview_nvim"),
  require("plugins.coding.gen_nvim"),
  require("plugins.coding.LuaSnip"),
  require("plugins.coding.leetcode_nvim"),
  require("plugins.coding.mason_nvim"),
  require("plugins.coding.mini_pairs"),
  require("plugins.coding.nvim-cmp"),
  require("plugins.coding.nvim-ts-context-commentstring"),
  require("plugins.coding.octo_nvim"),
  require("plugins.coding.supermaven-nvim"),
  require("plugins.coding.vim-dispatch"),
  require("plugins.coding.vim-fugitive"),
  require("plugins.coding.vim-rhubarb"),
  require("plugins.coding.yanky_nvim"),

  require("plugins.colorscheme.bgwinch_nvim"),
  require("plugins.colorscheme.tokyonight_nvim"),

  require("plugins.dap.nvim-dap"),

  require("plugins.editor.bigfile_nvim"),
  require("plugins.editor.fzf-lua"),
  require("plugins.editor.neo-tree_nvim"),
  require("plugins.editor.oil_nvim"),
  require("plugins.editor.telescope_nvim"),
  require("plugins.editor.vim-abolish"),
  require("plugins.editor.vim-bundler"),
  require("plugins.editor.vim-commentary"),
  require("plugins.editor.vim-dotenv"),
  require("plugins.editor.vim-endwise"),
  require("plugins.editor.vim-projectionist"),
  require("plugins.editor.vim-repeat"),
  require("plugins.editor.vim-unimpaired"),

  require("plugins.formatting.conform_nvim"),
  require("plugins.formatting.tabular"),

  require("plugins.lang.csv.rainbow_csv"),
  require("plugins.lang.python.jupytext_nvim"),
  require("plugins.lang.python.molten-nvim"),
  require("plugins.lang.python.quarto-nvim"),
  require("plugins.lang.ruby.vim-rails"),

  require("plugins.linting.nvim-lint"),

  require("plugins.lsp.nvim-lspconfig"),

  require("plugins.markdown.image_nvim"),
  require("plugins.markdown.img-clip_nvim"),

  require("plugins.test.neotest"),
  require("plugins.test.vim-test"),

  require("plugins.treesitter.nvim-treesitter"),

  require("plugins.ui.bufferline_nvim"),
  require("plugins.ui.dashboard-nvim"),
  require("plugins.ui.lualine_nvim"),
  require("plugins.ui.noice_nvim"),

  require("plugins.wiki.obsidian_nvim"),
  require("plugins.wiki.vimwiki"),

  require("plugins.wip"),
}
