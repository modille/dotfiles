local pick = function()
  local refactoring = require("refactoring")
  if LazyVim.pick.picker.name == "telescope" then
    return require("telescope").extensions.refactoring.refactors()
  elseif LazyVim.pick.picker.name == "fzf" then
    local fzf_lua = require("fzf-lua")
    local results = refactoring.get_refactors()

    local opts = {
      fzf_opts = {},
      fzf_colors = true,
      actions = {
        ["default"] = function(selected)
          refactoring.refactor(selected[1])
        end,
      },
    }
    fzf_lua.fzf_exec(results, opts)
  else
    refactoring.select_refactor()
  end
end

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
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },

  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
  },
  -- {
  --   "wassimk/ruby-lsp.nvim",
  --   version = "*",
  --   ft = "ruby",
  --   opts = {},
  -- },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "lewis6991/async.nvim",
    },
    lazy = false,
    keys = {
      { "<leader>r", "", desc = "+refactor", mode = { "n", "x" } },

      -- select_refactor is a picker, not an operator — no expr/return needed
      {
        "<leader>rs",
        function()
          require("refactoring").select_refactor()
        end,
        mode = { "n", "x" },
        desc = "Refactor",
      },

      {
        "<leader>ri",
        function()
          return require("refactoring").inline_var()
        end,
        mode = { "n", "x" },
        desc = "Inline Variable",
        expr = true,
      },

      -- NOTE: <leader>rb (Extract Block) has no equivalent in the new API — dropped

      {
        "<leader>rf",
        function()
          return require("refactoring").extract_func()
        end,
        mode = { "n", "x" },
        desc = "Extract Function",
        expr = true,
      },

      {
        "<leader>rF",
        function()
          return require("refactoring").extract_func_to_file()
        end,
        mode = { "n", "x" },
        desc = "Extract Function To File",
        expr = true,
      },

      {
        "<leader>rx",
        function()
          return require("refactoring").extract_var()
        end,
        mode = { "n", "x" },
        desc = "Extract Variable",
        expr = true,
      },

      -- was: debug.printf({ below = false }) — "below = false" meant above
      {
        "<leader>rP",
        function()
          return require("refactoring.debug").print_loc({ output_location = "above" })
        end,
        desc = "Debug Print",
        expr = true,
      },

      -- was: debug.print_var({ normal = true }) — "normal = true" auto-selected word;
      -- new API uses textobject operators: "iw" selects inner word in normal mode
      {
        "<leader>rp",
        function()
          return require("refactoring.debug").print_var({ output_location = "below" }) .. "iw"
        end,
        mode = { "n", "x" },
        desc = "Debug Print Variable",
        expr = true,
      },

      -- cleanup is now an operator — provide a motion/textobject after (e.g. "G" for whole file)
      {
        "<leader>rc",
        function()
          return require("refactoring.debug").cleanup({ restore_view = true })
        end,
        mode = { "n", "x" },
        desc = "Debug Cleanup",
        expr = true,
        remap = true,
      },
    },
  },

  { "joseotaviorf/dash.vim" },
}
