return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "work",
          path = "~/Dropbox/obsidian/work",
        },
      },
      templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },
      daily_notes = {
        template = "daily.md",
      },
    },
    keys = {
      { "<leader>w<leader>w", "<cmd>ObsidianToday<cr>" },
      { "<leader>w<leader>y", "<cmd>ObsidianYesterday<cr>" },
    },
  },
}
