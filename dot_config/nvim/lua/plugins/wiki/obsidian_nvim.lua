---@type LazySpec
return {
  {
    "obsidian-nvim/obsidian.nvim",
    -- version = "*", -- recommended, use latest release instead of latest commit
    version = "v3.11.0", -- checkbox was broken in v3.12.0
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      ui = { enable = false }, -- use render-markdown instead
      workspaces = {
        {
          name = "work",
          path = "~/Dropbox/obsidian/work",
        },
      },
      -- Optional, for templates (see https://github.com/obsidian-nvim/obsidian.nvim/wiki/Using-templates)
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function.
        -- Functions are called with obsidian.TemplateContext objects as their sole parameter.
        -- See: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Template#substitutions
        substitutions = {},
      },
      daily_notes = {
        folder = "daily",
        template = "daily.md",
      },
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ["<leader>ch"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ["<cr>"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true },
        },
      },
      -- Optional, customize how note IDs are generated given an optional title.
      ---@param title string|?
      ---@return string
      note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
          -- If title is given, transform it into valid file name.
          suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          -- If title is nil, just add 4 random uppercase letters to the suffix.
          for _ = 1, 4 do
            suffix = suffix .. string.char(math.random(65, 90))
          end
        end
        return tostring(os.time()) .. "-" .. suffix
      end,
      -- Either 'wiki' or 'markdown'.
      preferred_link_style = "markdown",
    },
    -- Vault structure (PARA method):
    --   0-inbox/                    quick capture, triage later
    --   1-projects/{project}/       active stories with end dates
    --   2-areas/                    ongoing responsibilities (brag, 1on1, peer-reviews)
    --   3-resources/learnings/      reference material
    --   4-archive/                  completed/inactive items
    --   daily/                      daily notes
    --
    -- Custom commands for creating notes with templates in specific directories:
    --   :ObsidianInbox random-thought               → 0-inbox/random-thought.md
    --   :ObsidianStory core CORE-123 feature name   → 1-projects/core/CORE-123-feature-name.md
    --   :ObsidianStory alpha ALPHA-45 thing         → 1-projects/alpha/ALPHA-45-thing.md
    --   :ObsidianLearning circuit-breaker           → 3-resources/learnings/circuit-breaker.md
    config = function(_, opts)
      require("obsidian").setup(opts)

      vim.api.nvim_create_user_command("ObsidianInbox", function(cmd)
        vim.cmd("ObsidianNew 0-inbox/" .. cmd.args)
        vim.cmd("ObsidianTemplate inbox")
      end, { nargs = 1 })

      vim.api.nvim_create_user_command("ObsidianStory", function(cmd)
        local args = vim.split(cmd.args, " ", { trimempty = true })
        local project = args[1]
        local name = table.concat(args, "-", 2)
        vim.cmd("ObsidianNew 1-projects/" .. project .. "/" .. name)
        vim.cmd("ObsidianTemplate story")
      end, { nargs = "+" })

      vim.api.nvim_create_user_command("ObsidianLearning", function(cmd)
        vim.cmd("ObsidianNew 3-resources/learnings/" .. cmd.args)
        vim.cmd("ObsidianTemplate learning")
      end, { nargs = 1 })
    end,
    keys = {
      { "<leader>w<leader>w", "<cmd>Obsidian today<cr>" },
      { "<leader>w<leader>y", "<cmd>Obsidian yesterday<cr>" },
    },
  },
}
