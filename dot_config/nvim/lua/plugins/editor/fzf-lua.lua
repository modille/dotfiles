return {
  {
    "ibhagwan/fzf-lua",
    enabled = true, -- this or telescope.nvim

    opts = {
      "telescope",
      fzf_colors = { true },
      fzf_opts = {
        ["--history"] = vim.fn.stdpath("data") .. "/fzf-lua-history",
      },
      winopts = {
        fullscreen = true, -- start fullscreen?
      },
      actions = {
        -- Use <c-s> instead of <a-i>
        ["ctrl-s"] = { require("fzf-lua").actions.toggle_ignore },
      },
    },

    keys = {
      {
        "<leader>fa",
        function()
          local current_file = vim.fn.expand("%:t")
          local basename = current_file:gsub("%..*$", "")
          local query

          if current_file:match("_spec") or current_file:match("_test") or current_file:match("Test") then
            query = basename
              :gsub("_spec$", "") -- Remove any test suffix
              :gsub("_test$", "")
              :gsub("Test$", "")
          else
            query = basename .. " test | spec"
          end

          require("fzf-lua").git_files({
            prompt = "Alternative files> ",
            cmd = "git ls-files --exclude-standard --cached --others",
            fzf_opts = {
              ["--query"] = query .. " ",
            },
          })
        end,
        mode = { "n" },
        desc = "file alternatives",
      },
      -- { "<leader>fg", LazyVim.pick("grep_cword", { root = false }),  desc = "Word (cwd)" },
      -- { "<leader>fg", LazyVim.pick("grep_visual", { root = false }), mode = "v",         desc = "Selection (cwd)" },
      {
        "<leader>fg",
        function()
          require("fzf-lua").live_grep() -- type search term, then ctrl-G to filter
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

          require("fzf-lua").grep({
            search = buf_vtext(),
            rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
          })
        end,
        mode = { "v" },
        desc = "file grep visual selection",
      },
      {
        "<leader>fos",
        function()
          require("fzf-lua").oldfiles()
        end,
        desc = "file old select",
      },
      {
        "<leader>fs",
        function()
          if vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null") == "" then
            require("fzf-lua").files()
          else
            require("fzf-lua").git_files({
              show_untracked = true,
            })
          end
        end,
        desc = "file select",
      },
      {
        "<leader><leader>fs",
        function()
          if vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null") == "" then
            require("fzf-lua").files()
          else
            require("fzf-lua").git_files({
              git_submodules = true,
            })
          end
        end,
        desc = "file select recurse submodules",
      },
      {
        "<leader>bs",
        function()
          require("fzf-lua").buffers({
            previewer = false,
            sort_lastused = true,
          })
        end,
        desc = "buffer select",
      },
      {
        "<leader>fds",
        function()
          require("fzf-lua").files({
            prompt = "dotfiles> ",
            cwd = os.getenv("HOME") .. "/.config",
            no_hidden = true,
          })
        end,
        desc = "file dotfiles select",
      },
      {
        "<leader>fdg",
        function()
          local search = vim.fn.input("dotfiles 🔍 ")
          require("fzf-lua").grep({
            search = search,
            cwd = os.getenv("HOME") .. "/.config",
            rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
          })
        end,
        desc = "file dotfiles grep",
      },
      {
        "<leader>fws",
        function()
          require("fzf-lua").files({
            prompt = "wiki> ",
            cwd = os.getenv("HOME") .. "/Dropbox/obsidian", -- TODO: and Dropbox/vimwiki
            no_hidden = true,
          })
        end,
        desc = "file wiki select",
      },
      {
        "<leader>fwg",
        function()
          local search = vim.fn.input("wiki 🔍 ")
          require("fzf-lua").grep({
            search = search,
            cwd = os.getenv("HOME") .. "/Dropbox/vimwiki",
            rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
          })
        end,
        desc = "file wiki grep",
      },
    },
  },
}
