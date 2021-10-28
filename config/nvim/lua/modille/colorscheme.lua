-- A job could switch these automatically, but for now just choose one at startup
local hour = tonumber(os.date('%H'))
local colorscheme_module = (hour < 6 or hour > 20) and 'modille.colorscheme_dark' or 'modille.colorscheme_light'
require(colorscheme_module)
