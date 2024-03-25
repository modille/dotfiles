local wezterm = require('wezterm')

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.color_scheme = 'Solarized (light) (terminal.sexy)'
config.colors = {
  cursor_bg = '#586e75',
  cursor_fg = '#eee8d5',
}
config.default_cursor_style = 'SteadyBar'
config.default_prog = { '/opt/homebrew/bin/fish' }
config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 14.0
config.keys = {
  {
    key = 'Enter',
    mods = 'CMD',
    action = wezterm.action.ToggleFullScreen,
  },
}
config.native_macos_fullscreen_mode = true
config.scrollback_lines = 200000
config.tab_bar_at_bottom = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- TODO: Use font_rules for cursive italics
-- See https://wezfurlong.org/wezterm/config/lua/config/font_rules.html

return config
