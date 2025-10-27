-- return {}
return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>dA",
        function()
          require("config.dap.rdbg-attach").attach_to_rdbg()
        end,
        desc = "Attach to rdbg session",
      },
      {
        "<leader>dS",
        function()
          require("config.dap.rdbg-attach").attach_to_services_rails()
        end,
        desc = "Attach to Services Rails",
      },
    },
    -- config = function()
    --   -- From LazyVim:
    --   --
    --   -- load mason-nvim-dap here, after all adapters have been setup
    --   if LazyVim.has("mason-nvim-dap.nvim") then
    --     require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
    --   end

    --   vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

    --   for name, sign in pairs(LazyVim.config.icons.dap) do
    --     sign = type(sign) == "table" and sign or { sign }
    --     vim.fn.sign_define(
    --       "Dap" .. name,
    --       { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    --     )
    --   end

    --   -- setup dap config by VsCode launch.json file
    --   local vscode = require("dap.ext.vscode")
    --   local json = require("plenary.json")
    --   vscode.json_decode = function(str)
    --     return vim.json.decode(json.json_strip_comments(str))
    --   end

    --   -- From me:
    --   --
    --   local dap = require("dap")
    --   -- Configure nvim-dap-ruby with attach configuration
    --   require("dap-ruby").setup()
    --   -- Add custom attach configuration
    --   dap.configurations.ruby = vim.list_extend(dap.configurations.ruby or {}, {
    --     {
    --       type = "ruby",
    --       request = "attach",
    --       name = "Attach to existing rdbg session",
    --       -- This will be populated dynamically
    --       localfs = true,
    --       waitOn = "start",
    --     },
    --   })
    -- end,
  },

  {
    "rcarriga/nvim-dap-ui",
    enabled = false, -- this or nvim-dap-view
    opts = {
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "",
          pause = "",
          play = "",
          run_last = "",
          step_back = "",
          step_into = "",
          step_out = "",
          step_over = "",
          terminate = "",
        },
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = "single",
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      force_buffers = true,
      icons = {
        collapsed = "",
        current_frame = "",
        expanded = "",
      },
      layouts = {
        -- {
        --   elements = {
        --     {
        --       id = "scopes",
        --       size = 0.25,
        --     },
        --     {
        --       id = "breakpoints",
        --       size = 0.25,
        --     },
        --     {
        --       id = "stacks",
        --       size = 0.25,
        --     },
        --     {
        --       id = "watches",
        --       size = 0.25,
        --     },
        --   },
        --   position = "left",
        --   size = 40,
        -- },
        {
          elements = {
            -- {
            --   id = "repl",
            --   size = 0.5,
            -- },
            -- {
            --   id = "console",
            --   size = 0.5,
            -- },
            {
              id = "repl",
              size = 1.0,
            },
          },
          position = "bottom",
          size = 20,
        },
      },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t",
      },
      render = {
        indent = 1,
        max_value_lines = 100,
      },
    },
  },

  {
    "igorlfs/nvim-dap-view",
    keys = {
      {
        "<leader>du",
        function()
          require("dap-view").toggle()
        end,
        desc = "Toggle Dap View",
      },
      {
        "<leader>dr",
        function()
          require("dap-view").jump_to_view("repl")
          vim.cmd("set syntax=ruby")
        end,
        desc = "Dap Ruby REPL",
      },
      { "<leader>dw", "<cmd>DapViewWatch<cr>", desc = "Add Watch Expression", mode = { "n", "v" } },
    },
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
      winbar = {
        default_section = "repl",
        controls = {
          enabled = true,
        },
      },
    },
  },
}
