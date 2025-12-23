---@type LazySpec
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
    enabled = false,
    opts = {},
  },

  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      load_coverage_cb = function(ftype)
        vim.notify("Loaded " .. ftype .. " coverage")
      end,
    },
  },

  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  {
    "robitx/gp.nvim",
    config = function()
      local conf = {
        -- For customization, refer to Install > Configuration in the Documentation/Readme
        openai_api_key = os.getenv("OPENAI_API_KEY"),
        providers = {
          openai = {
            disable = false,
            endpoint = "https://api.openai.com/v1/chat/completions",
            -- secret = os.getenv("OPENAI_API_KEY"),
            model = { model = "auto" },
          },
          ollama = {
            disable = false,
            endpoint = "http://localhost:11434/v1/chat/completions",
            secret = "dummy_secret",
          },
        },
        agents = {
          {
            name = "ChatGPT4o",
            disable = true,
          },
        },
      }
      require("gp").setup(conf)

      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
    end,
  },
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      indent = {
        scope = {
          underline = false, -- underline the start of the scope
        },
      },
    },
  },

  {
    "alker0/chezmoi.vim",
    lazy = false,
    init = function()
      -- This option is required.
      vim.g["chezmoi#use_tmp_buffer"] = true
      -- add other options here if needed.
    end,
  },

  -- {
  --   "folke/sidekick.nvim",
  --   opts = {
  --     nes = {
  --       enabled = false,
  --     },
  --   },
  -- },
  --
  -- lazy.nvim
  {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      dashboard = {
        enabled = false,
        -- your dashboard configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      },
    },
  },

  {
    "3rd/diagram.nvim",
    dependencies = {
      "3rd/image.nvim",
    },
    opts = {
      -- Disable automatic rendering for manual-only workflow
      events = {
        render_buffer = {}, -- Empty = no automatic rendering
        clear_buffer = { "BufLeave" },
      },
      renderer_options = {
        mermaid = {
          theme = "dark",
          scale = 2,
        },
      },
    },
    keys = {
      {
        "<leader>rd", -- "render diagram"
        function()
          require("diagram").show_diagram_hover()
        end,
        mode = "n",
        ft = { "markdown", "norg" }, -- Only in these filetypes
        desc = "Show diagram in new tab",
      },
    },
  },

  {
    "zhisme/copy_with_context.nvim",
    config = function()
      require("copy_with_context").setup({
        -- Customize mappings
        mappings = {
          relative = "<leader>cy",
          absolute = "<leader>cY",
          remote = "<leader>ce",
        },
        formats = {
          default = "# {filepath}:{line}", -- Used by relative and absolute mappings
          remote = "# {remote_url}",
        },
        -- whether to trim lines or not
        trim_lines = false,
      })
    end,
  },
}
