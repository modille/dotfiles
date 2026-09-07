---@type LazySpec
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
    config = function()
      -- From LazyVim:
      --
      -- load mason-nvim-dap here, after all adapters have been setup
      if LazyVim.has("mason-nvim-dap.nvim") then
        require("mason-nvim-dap").setup(LazyVim.opts("mason-nvim-dap.nvim"))
      end

      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(LazyVim.config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end

      -- setup dap config by VsCode launch.json file
      local vscode = require("dap.ext.vscode")
      local json = require("plenary.json")
      vscode.json_decode = function(str)
        return vim.json.decode(json.json_strip_comments(str))
      end

      -- From me:
      --
      local dap = require("dap")
      -- Configure nvim-dap-ruby with attach configuration
      require("dap-ruby").setup()
      -- Add custom attach configuration
      dap.configurations.ruby = vim.list_extend(dap.configurations.ruby or {}, {
        {
          type = "ruby",
          request = "attach",
          name = "Attach to existing rdbg session",
          -- This will be populated dynamically
          localfs = true,
          waitOn = "start",
        },
      })
    end,
  },
}
