return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
      "olimorris/neotest-rspec",
      "vim-test/vim-test",
      "nvim-neotest/neotest-vim-test",
      "weilbith/neotest-gradle",
    },
    opts = function()
      local neotest_jest_adapter = require("neotest-jest")({
        jestCommand = "npm test --",
      })
      neotest_jest_adapter.filter_dir = function(name)
        return name ~= "node_modules" and name ~= "__snapshots__"
      end
      return {
        log_level = 1,
        adapters = {
          neotest_jest_adapter,
          require("neotest-rspec"),
          require("neotest-gradle"),
          require("neotest-vim-test")({
            allow_file_types = { "cucumber" },
          }),
          ["neotest-python"] = {
            -- Here you can specify the settings for the adapter, i.e.
            runner = "pytest",
            -- python = ".venv/bin/python",
          },
        },
        status = {
          enabled = true,
          signs = true,
          virtual_text = false,
        },
      }
    end,
    keys = {
      {
        "<leader>tn",
        function()
          require("neotest").run.run()
        end,
        desc = "Test nearest",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Test file",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Test last",
      },
      -- {
      --   "<leader>ts",
      --   function()
      --     require("neotest").run.run({ suite = true })
      --   end,
      --   desc = "Test suite",
      -- },
      {
        "<leader>tdn",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        desc = "Test debug nearest",
      },
      {
        "<leader>tdf",
        function()
          require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
        end,
        desc = "Test debug file",
      },
      {
        "<leader>tdl",
        function()
          require("neotest").run.run_last({ strategy = "dap" })
        end,
        desc = "Test debug last",
      },
      -- {
      --   "<leader>tds",
      --   function()
      --     require("neotest").run.run({ suite = true, strategy = "dap" })
      --   end,
      --   desc = "Test debug suite",
      -- },
      {
        "<leader>twj",
        function()
          require("neotest").run.run({ jestCommand = "jest --watch " })
        end,
        desc = "Test watch jest",
      },
      -- {
      --   "<leader>to",
      --   function()
      --     require("neotest").output.open({ enter = true })
      --   end,
      --   desc = "Test output",
      -- },
    },
  },
}
