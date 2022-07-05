local module = vim.g.modille_background == 'dark' and 'modille.colorscheme_dark' or 'modille.colorscheme_light'
require(module).load()
