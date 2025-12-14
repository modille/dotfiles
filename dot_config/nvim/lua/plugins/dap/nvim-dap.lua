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
