---@type LazySpec
return {
  {
    "saghen/blink.cmp",
    enabled = false, -- this or nvim-cmp
    dependencies = {
      {
        "saghen/blink.compat",
        opts = {
          impersonate_nvim_cmp = true,
          debug = false,
        },
      },
      {
        "philosofonusus/ecolog.nvim",
        opts = {
          integrations = {
            blink_cmp = true,
          },
        },
      },
      "hrsh7th/cmp-calc",
      "rcarriga/cmp-dap",
      -- "tzachar/cmp-ai",
    },

    opts = function(_, opts)
      local blink = require("blink.cmp")

      -- TODO: Get dap completion working with LazyVim + blink
      opts.enabled = function()
        return vim.bo.buftype ~= "prompt" -- or require("cmp_dap").is_dap_buffer()
      end

      opts.completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        -- https://cmp.saghen.dev/configuration/completion.html#documentation
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        menu = { draw = { columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } } } },
      }

      opts.fuzzy = { implementation = "prefer_rust_with_warning" }

      opts.keymap = {
        preset = "enter",
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      }

      -- TODO: Test each of these...
      opts.sources = {
        default = { "ecolog", "lsp", "buffer", "snippets", "path", "omni" }, -- omni is for cucumber_language_server
        compat = { "calc" },
        providers = {
          ecolog = { name = "ecolog", module = "ecolog.integrations.cmp.blink_cmp" },
        },
      }

      opts.signature = { enabled = true }

      return opts
    end,
  },
}
