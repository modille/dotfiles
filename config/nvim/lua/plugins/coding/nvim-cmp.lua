return {
  {
    "nvim-cmp",
    dependencies = {
      "SergioRibera/cmp-dotenv",
      "hrsh7th/cmp-calc",
      "hrsh7th/cmp-cmdline",
      "rcarriga/cmp-dap",
      -- "tzachar/cmp-ai",
    },

    opts = function(_, opts)
      -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#vim-vsnip
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.preselect = cmp.PreselectMode.None
      opts.completion = {
        completeopt = "menu,menuone,noselect", -- for preselect use 'menu,menuone,noinsert'
      }
      opts.mapping = cmp.mapping.preset.insert({
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<C-y>"] = cmp.mapping.confirm({
          select = false,
        }),
        ["<CR>"] = cmp.mapping.confirm({
          select = false,
        }),
        -- https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#vim-vsnip
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- that way you will only jump inside the snippet region
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        -- ["<C-x>"] = cmp.mapping(
        --   cmp.mapping.complete({
        --     config = {
        --       sources = cmp.config.sources({
        --         { name = "cmp_ai" },
        --       }),
        --     },
        --   }),
        --   { "i" }
        -- ),
      })

      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "luasnip" },
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              -- https://github.com/hrsh7th/cmp-buffer#all-buffers
              return vim.api.nvim_list_bufs()
            end,
          },
        },
        { name = "dotenv" },
        { name = "omni" }, -- for cucumber_language_server
        { name = "calc" },
      })

      opts.formatting = {
        format = function(entry, item)
          local icons = require("lazyvim.config").icons.kinds
          if icons[item.kind] then
            item.kind = icons[item.kind] .. item.kind
          end
          item.menu = ({
            nvim_lsp = "[LSP]",
            path = "[Path]",
            luasnip = "[LuaSnip]",
            buffer = "[Buffer]",
            omni = "[Omni]",
            calc = "[Calc]",
            -- cmp_ai = "[AI]",
          })[entry.source.name]
          return item
        end,
      }

      -- https://github.com/rcarriga/cmp-dap
      opts.enabled = function()
        return vim.api.nvim_get_option_value("buftype", { buf = 0 }) ~= "prompt" or require("cmp_dap").is_dap_buffer()
      end
    end,

    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end
      local cmp = require("cmp")
      cmp.setup(opts)

      -- https://github.com/rcarriga/cmp-dap
      cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
        sources = {
          { name = "dap" },
        },
      })

      -- https://github.com/hrsh7th/cmp-cmdline
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
}
