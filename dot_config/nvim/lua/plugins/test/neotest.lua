---@type LazySpec
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "haydenmeade/neotest-jest",
      "olimorris/neotest-rspec",
      "vim-test/vim-test",
      -- "nvim-neotest/neotest-vim-test",
      "weilbith/neotest-gradle",
      "zidhuss/neotest-minitest",
    },
    opts = function()
      return {
        log_level = 1,
        adapters = {
          require("neotest-jest"),
          require("neotest-minitest"),
          require("neotest-rspec"),
          require("neotest-gradle"),
          -- require("neotest-vim-test")({
          --   allow_file_types = { "cucumber" },
          -- }),
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
        consumers = {
          neotest_consumers = function(client)
            return {
              yank = function()
                local async = require("neotest.async")

                local file = async.fn.expand("%:p")
                local row = async.fn.getpos(".")[2] - 1
                local position = client:get_nearest(file, row, {})
                if not position then
                  print("no position found")
                  return
                end

                if not position then
                  return
                end

                local file = async.fn.expand("%:p")

                local adapter_name, adapter = client:get_adapter(file)

                local command = adapter.build_spec({
                  tree = position,
                }).command

                -- convert to string
                local command_str = table.concat(command, " ")

                vim.fn.setreg("+", command_str)
              end,
            }
          end,
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
        "<leader>ta",
        function()
          require("neotest").run.attach()
        end,
        desc = "Test attach",
      },
      {
        "<leader>twj",
        function()
          require("neotest").run.run({ jestCommand = "npx jest --watch " })
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
      {
        "<leader>ty",
        function()
          require("neotest").neotest_consumers.yank()
        end,
        desc = "test yank command",
      },
    },
  },
}
