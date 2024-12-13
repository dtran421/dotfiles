local wezterm = require 'wezterm'
local config = {}

config.initial_rows = 26
config.initial_cols = 90
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.color_scheme = 'Catppuccin Mocha'
config.colors = {
  background = '#181826',
}
config.font =
  wezterm.font('JetBrains Mono', { weight = 'DemiBold' })
config.font_size = 16.0

config.keys = {}

for i = 1, 8 do
  -- CTRL+ALT + number to move to that position
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'CTRL|ALT',
    action = wezterm.action.MoveTab(i - 1),
  })
end

return config
