local colors = require("colors")
local icons = require("icons")

sbar.add("item", { width = 7 })

sbar.add("item", {
	icon = {
		font = { size = 18.0 },
		---@type string
		string = icons.apple,
		padding_right = 8,
		padding_left = 8,
		---@type number
		color = colors.magenta,
	},
	label = { drawing = false },
	padding_left = 1,
	padding_right = 1,
	click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0",
})
