return {
  -- WIP: sonar for Dockerfile
  -- LspInfo showed it running, but never got any diagnostics
  -- {
  --   url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
  --   -- dependencies = {
  --   --   "mfussenegger/nvim-jdtls",
  --   -- },
  --   ft = { "dockerfile", "javascript" },
  --   config = function()
  --     require("sonarlint").setup({
  --       server = {
  --         cmd = {
  --           "sonarlint-language-server",
  --           "-stdio",
  --           "-analyzers",
  --           vim.fn.expand("$MASON/share/sonarlint-analyzers/sonariac.jar"),
  --           vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjs.jar"),
  --         },
  --       },
  --       filetypes = {
  --         "dockerfile",
  --         "javascript",
  --       },
  --     })
  --   end,
  -- },

  -- WIP: code runner
  {
    "stevearc/overseer.nvim",
    opts = {},
  },
}
