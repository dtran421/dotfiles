---@type Colors
local colors = require("colors")
---@type Icons
local icons = require("icons")

sbar.add("item", { width = 7 })

sbar.add("item", {
	icon = {
		font = { size = 18.0 },
		string = icons.apple,
		padding_right = 8,
		padding_left = 8,
		color = colors.magenta,
	},
	label = { drawing = false },
	padding_left = 1,
	padding_right = 1,
	click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0",
})
