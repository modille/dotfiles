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

  {
    "Wansmer/treesj",
    -- keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup({
        ---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
        use_default_keymaps = false,
      })
    end,
    keys = {
      {
        "<space>bt",
        function()
          require("treesj").toggle()
        end,
        desc = "Toggle treesj",
      },
      -- { "<space>j", function() require("treesj").join() end, desc = "Join treesj" },
      -- { "<space>s", function() require("treesj").split() end, desc = "Split treesj" },
    },
  },

  {
    "sphamba/smear-cursor.nvim",
    opts = {},
  },
}
