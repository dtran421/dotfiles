local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	height = 40,
	---@type number
	color = colors.bar.bg,
	y_offset = 8,
	margin = 6,
	corner_radius = 9,
	padding_right = 2,
	padding_left = 2,
})
