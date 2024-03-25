return {
  {
    "tpope/vim-fugitive",
    lazy = false, -- for "review" git alias
    dependencies = { "shumphrey/fugitive-gitlab.vim" },
    init = function()
      vim.g.fugitive_gitlab_domains = { "https://gitlab.upmc.com", "https://gitlab.com" }
      vim.cmd([[ command! -nargs=1 Browse silent execute '!open' shellescape(<q-args>,1) ]]) -- fix :GBrowse when netrw isn't loaded
    end,
    keys = {
      { "<Leader>gs", "<cmd>Git<CR>" },
      { "<Leader>gb", "<cmd>Git blame<CR>" },
      { "<Leader>gl", "<cmd>Gclog<CR>" },
    },
  },
}
