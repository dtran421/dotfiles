local wezterm = require 'wezterm'
local config = {}

config.exit_behavior = 'Hold'
config.window_decorations = "RESIZE"
config.initial_rows = 26
config.initial_cols = 90

config.color_scheme = 'tokyonight'
config.font = 
    wezterm.font('JetBrains Mono', { weight = 'DemiBold' })
config.font_size = 16.0
config.foreground_text_hsb = {
    brightness = 1.25,
}

return config
