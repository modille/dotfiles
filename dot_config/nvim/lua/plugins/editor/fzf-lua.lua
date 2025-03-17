return {
  {
    "ibhagwan/fzf-lua",
    enabled = true, -- this or telescope.nvim

    opts = {
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = {
          layout = "down",
          height = 0.4, -- 40% of total height
        },
      },
      keymap = {
        -- fzf '--bind=' options
        ["ctrl-z"] = "abort",
        ["ctrl-u"] = "unix-line-discard",
        ["ctrl-f"] = "half-page-down",
        ["ctrl-b"] = "half-page-up",
        ["ctrl-a"] = "beginning-of-line",
        ["ctrl-e"] = "end-of-line",
        ["alt-a"] = "toggle-all",
        ["alt-g"] = "first",
        ["alt-G"] = "last",
        -- Only valid with fzf previewers (bat/cat/git/etc)
        ["f3"] = "toggle-preview-wrap",
        ["f4"] = "toggle-preview",
        ["shift-down"] = "preview-page-down",
        ["shift-up"] = "preview-page-up",
      },
      actions = {
        files = {
          -- Pickers inheriting these actions:
          --   files, git_files, git_status, grep, lsp, oldfiles, quickfix, loclist,
          --   tags, btags, args, buffers, tabs, lines, blines
          -- `file_edit_or_qf` opens a single selection or sends multiple selection to quickfix
          -- replace `enter` with `file_edit` to open all files/bufs whether single or multiple
          -- replace `enter` with `file_switch_or_edit` to attempt a switch in current tab first
          ["enter"] = require("fzf-lua").actions.file_edit_or_qf,
          ["ctrl-s"] = require("fzf-lua").actions.file_split,
          ["ctrl-v"] = require("fzf-lua").actions.file_vsplit,
          ["ctrl-t"] = require("fzf-lua").actions.file_tabedit,
          ["alt-q"] = require("fzf-lua").actions.file_sel_to_qf,
          ["alt-Q"] = require("fzf-lua").actions.file_sel_to_ll,
          ["ctrl-i"] = require("fzf-lua").actions.toggle_ignore,
          ["ctrl-h"] = require("fzf-lua").actions.toggle_hidden,
          ["alt-f"] = require("fzf-lua").actions.toggle_follow,
        },
      },
    },

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

          require("fzf-lua").git_files({
            prompt = "Alternative files> ",
            cmd = "git ls-files --exclude-standard --cached --others",
            default_text = default_text .. " ",
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
          require("fzf-lua").live_grep()
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
            cwd = os.getenv("HOME") .. "/.local/share/chezmoi",
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
            cwd = os.getenv("HOME") .. "/.local/share/chezmoi",
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
            cwd = os.getenv("HOME") .. "/Dropbox",
            search_dirs = { "vimwiki", "obsidian" },
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
