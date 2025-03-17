local M = {}

-- reminder: as of nvim 0.9, you can use :Inspect and :InspectTree

function M.dark()
  vim.o.background = "dark"
  vim.cmd.colorscheme("tokyonight-moon")
end

function M.light()
  vim.o.background = "light"
  vim.cmd.colorscheme("tokyonight-day")
end

function M.setup()
  -- Read and store current system theme
  if vim.fn.system("defaults read -g AppleInterfaceStyle"):gsub("\n", ""):sub(-4) == "Dark" then
    vim.g.modille_background = "dark"
  else
    vim.g.modille_background = "light"
  end

  -- Load light/dark colorscheme and status line based on current system theme
  if vim.g.modille_background == "dark" then
    M.dark()
  else
    M.light()
  end

  -- Auto-switch light/dark colorscheme and status line based on SIGWINCH
  local Job = require("plenary.job")
  require("bgwinch").setup({
    set_bg = function()
      local j = Job:new({ command = "defaults", args = { "read", "-g", "AppleInterfaceStyle" } })
      j:sync()
      if j:result()[1] == "Dark" and vim.g.modille_background == "light" then
        vim.g.modille_background = "dark"
        M.dark()
      elseif vim.g.modille_background == "dark" then
        vim.g.modille_background = "light"
        M.light()
      end
    end,
  })
end

return M
