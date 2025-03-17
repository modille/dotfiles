return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = false, -- this or fzf-lua
    opts = function(_, opts)
      opts.defaults.get_selection_window = function()
        return 0
      end

      -- On macOS, M-q enters "œ" and it's hard to disable that, so use something else for the default M-q behavior
      local actions = require("telescope.actions")
      opts.defaults.mappings.i = vim.tbl_extend("force", opts.defaults.mappings.i, {
        ["<C-f>"] = actions.send_selected_to_qflist + actions.open_qflist,
      })

      return opts
    end,
    keys = {
      {
        "<leader>fa",
        function()
          local current_file = vim.fn.expand("%:t")
          local basename = current_file:gsub("%..*$", "")
          local default_text

          if current_file:match("_spec") or current_file:match("_test") or current_file:match("Test") then
            default_text = basename
                :gsub("_spec$", "") -- Remove any test suffix
                :gsub("_test$", "")
                :gsub("Test$", "")
          else
            default_text = basename .. " test | spec"
          end

          require("telescope.builtin").git_files({
            prompt_title = "Alternative files",
            default_text = default_text .. " ",
          })
        end,
        mode = { "n" },
        { desc = "file alternatives" },
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").grep_string({ additional_args = { "--hidden" }, search = vim.fn.input("🔍 ") })
        end,
        mode = { "n" },
        desc = "file grep",
      },
      {
        "<leader>fg",
        function()
          local buf_vtext = function()
            local a_orig = vim.fn.getreg("a")
            local mode = vim.fn.mode()
            if mode ~= "v" and mode ~= "V" then
              vim.cmd([[normal! gv]])
            end
            vim.cmd([[normal! "aygv]])
            local text = vim.fn.getreg("a")
            vim.fn.setreg("a", a_orig)
            return text
          end

          require("telescope.builtin").grep_string({ additional_args = { "--hidden" }, search = buf_vtext() })
        end,
        mode = { "v" },
        desc = "file grep visual selection",
      },
      {
        "<leader>fos",
        "<cmd>Telescope oldfiles<cr>",
        desc = "file old select",
      },
      {
        "<leader>fs",
        function()
          local builtin = require("telescope.builtin")
          local opts = {
            show_untracked = true,
          } -- define here if you want to define something
          local ok = pcall(builtin.git_files, opts)
          if not ok then
            builtin.find_files(opts)
          end
        end,
        desc = "file select",
      },
      {
        "<leader><leader>fs",
        function()
          local builtin = require("telescope.builtin")
          local opts = {
            recurse_submodules = true,
          } -- define here if you want to define something
          local ok = pcall(builtin.git_files, opts)
          if not ok then
            builtin.find_files(opts)
          end
        end,
        desc = "file select recurse submodules",
      },
      {
        "<leader>bs",
        function()
          require("telescope.builtin").buffers({ previewer = false, sort_lastused = true })
        end,
        desc = "buffer select",
      },
      {
        "<leader>fds",
        function()
          require("telescope.builtin").find_files({
            prompt_title = "dotfiles >",
            cwd = os.getenv("HOME") .. "/git/github.com/modille/dotfiles",
            hidden = false,
          })
        end,
        desc = "file dotfiles select",
      },
      {
        "<leader>fdg",
        function()
          require("telescope.builtin").grep_string({
            search = vim.fn.input("dotfiles 🔍 "),
            cwd = os.getenv("HOME") .. "/git/github.com/modille/dotfiles",
            hidden = false,
          })
        end,
        desc = "file dotfiles grep",
      },
      {
        "<leader>fws",
        function()
          require("telescope.builtin").find_files({
            prompt_title = "wiki >",
            cwd = os.getenv("HOME") .. "/Dropbox",
            search_dirs = { "vimwiki", "obsidian" },
            hidden = false,
          })
        end,
        desc = "file wiki select",
      },
      {
        "<leader>fwg",
        function()
          require("telescope.builtin").grep_string({
            search = vim.fn.input("wiki 🔍 "),
            cwd = os.getenv("HOME") .. "/Dropbox/vimwiki",
            hidden = false,
          })
        end,
        desc = "file wiki grep",
      },
    },
  },
}
