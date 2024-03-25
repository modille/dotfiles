return {
  -- LazyVim extras
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.editor.aerial" },
  { import = "lazyvim.plugins.extras.editor.leap" },
  { import = "lazyvim.plugins.extras.editor.navic" },
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.java" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.ruby" },
  { import = "lazyvim.plugins.extras.lang.terraform" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  { import = "lazyvim.plugins.extras.linting.eslint" },
  { import = "lazyvim.plugins.extras.test.core" },
  { import = "lazyvim.plugins.extras.ui.mini-animate" },
  { import = "lazyvim.plugins.extras.util.dot" },
  { import = "lazyvim.plugins.extras.util.mini-hipatterns" },

  -- Plugins
  require("plugins.coding.diffview_nvim"),
  require("plugins.coding.nvim-cmp"),
  require("plugins.coding.octo_nvim"),
  require("plugins.coding.refactoring_nvim"),
  require("plugins.coding.vim-dispatch"),
  require("plugins.coding.vim-fugitive"),
  require("plugins.coding.vim-rhubarb"),

  require("plugins.colorscheme.bgwinch_nvim"),

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
  require("plugins.editor.vim-surround"),
  require("plugins.editor.vim-unimpaired"),

  require("plugins.formatting.conform_nvim"),
  require("plugins.formatting.tabular"),

  require("plugins.lang.markdown.headlines_nvim"),
  require("plugins.lang.ruby.vim-rails"),

  require("plugins.linting.nvim-lint"),

  require("plugins.lsp.nvim-lspconfig"),

  require("plugins.test.neotest"),
  require("plugins.test.vim-test"),

  require("plugins.treesitter.neogen"),
  require("plugins.treesitter.nvim-treesitter"),

  require("plugins.ui.bufferline_nvim"),
  require("plugins.ui.zen-mode_nvim"),

  require("plugins.wiki.obsidian_nvim"),
  require("plugins.wiki.vimwiki"),
}
