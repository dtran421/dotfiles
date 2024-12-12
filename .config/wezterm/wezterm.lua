local wezterm = require 'wezterm'
local config = {}

config.initial_rows = 26
config.initial_cols = 90
config.enable_tab_bar = false

config.color_scheme = 'tokyonight'
config.font = 
    wezterm.font('JetBrains Mono', { weight = 'DemiBold' })
config.font_size = 16.0

return config
