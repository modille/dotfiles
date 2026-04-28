---@type LazySpec
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
      files = {
        -- previewer      = "bat",          -- uncomment to override previewer
        -- (name from 'previewers' table)
        -- set to 'false' to disable
        prompt = "Files❯ ",
        multiprocess = true, -- run command in a separate process
        git_icons = false, -- show git icons?
        file_icons = true, -- show file icons (true|"devicons"|"mini")?
        color_icons = true, -- colorize file|git icons
        -- path_shorten   = 1,              -- 'true' or number, shorten path?
        -- Uncomment for custom vscode-like formatter where the filename is first:
        -- e.g. "fzf-lua/previewer/fzf.lua" => "fzf.lua previewer/fzf-lua"
        -- formatter      = "path.filename_first",
        -- executed command priority is 'cmd' (if exists)
        -- otherwise auto-detect prioritizes `fd`:`rg`:`find`
        -- default options are controlled by 'fd|rg|find|_opts'
        -- cmd            = "rg --files",
        find_opts = [[-type f \! -path '*/.git/*']],
        rg_opts = [[--color=never --hidden --files -g "!.git"]],
        fd_opts = [[--color=never --hidden --type f --type l --exclude .git]],
        dir_opts = [[/s/b/a:-d]],
        -- by default, cwd appears in the header only if {opts} contain a cwd
        -- parameter to a different folder than the current working directory
        -- uncomment if you wish to force display of the cwd as part of the
        -- query prompt string (fzf.vim style), header line or both
        -- cwd_header = true,
        cwd_prompt = true,
        cwd_prompt_shorten_len = 32, -- shorten prompt beyond this length
        cwd_prompt_shorten_val = 1, -- shortened path parts length
        toggle_ignore_flag = "--no-ignore", -- flag toggled in `actions.toggle_ignore`
        toggle_hidden_flag = "--hidden", -- flag toggled in `actions.toggle_hidden`
        toggle_follow_flag = "-L", -- flag toggled in `actions.toggle_follow`
        hidden = true, -- enable hidden files by default
        follow = false, -- do not follow symlinks by default
        no_ignore = false, -- respect ".gitignore"  by default
        absolute_path = false, -- display absolute paths
        actions = {
          -- inherits from 'actions.files', here we can override
          -- or set bind to 'false' to disable a default action
          -- uncomment to override `actions.file_edit_or_qf`
          --   ["enter"]     = actions.file_edit,
          -- custom actions are available too
          --   ["ctrl-y"]    = function(selected) print(selected[1]) end,
        },
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
          -- autocmd will automatically `chezmoi apply` on save
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
          -- autocmd will automatically `chezmoi apply` on save
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
            cwd = os.getenv("HOME") .. "/Dropbox/obsidian",
            rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
          })
        end,
        desc = "file wiki grep",
      },
    },
  },
}
