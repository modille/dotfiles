---@type LazySpec
return {
  {
    "wassimk/rails-fixture-ls.nvim",
    version = "*",
    ft = "ruby",
    config = function()
      vim.lsp.enable("rails_fixture_ls")
    end,
  },
}
