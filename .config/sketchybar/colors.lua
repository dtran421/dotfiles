return {
	black = 0xff181819,
	white = 0xffe2e2e3,
	red = 0xfff48ba8,
	green = 0xffa7e3a1,
	blue = 0xff89b5fa,
	yellow = 0xffe7c664,
	orange = 0xfff39660,
	magenta = 0xffcba5f7,
	grey = 0xff7f8490,
	transparent = 0x00000000,

	bar = {
		bg = 0xf02c2e34,
		border = 0xff2c2e34,
	},
	popup = {
		bg = 0xc02c2e34,
		border = 0xff7f8490,
	},
	bg1 = 0xff454759,
	bg2 = 0xff585B70,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
