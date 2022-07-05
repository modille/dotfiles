local function load()
  vim.o.termguicolors = true
  vim.o.background = 'dark'
  local base16 = require('base16')
  base16(base16.themes['solarized-dark'], true)

  -- vim.o.termguicolors = true
  -- vim.o.background = 'dark'
  -- vim.cmd('colorscheme soluarized')
end

return {
  load = load,
}
