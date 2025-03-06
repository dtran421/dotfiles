local settings = require("settings")

local front_app = sbar.add("item", "front_app", {
	padding_left = -2,
	display = "active",
	icon = { drawing = false },
	label = {
		font = {
			---@type number
			style = settings.font.style_map["Black"],
			size = 12.0,
		},
	},
	updates = true,
})

front_app:subscribe("front_app_switched", function(env)
	front_app:set({
		label = {
			---@type number
			string = env.INFO,
		},
	})
end)

front_app:subscribe("mouse.clicked", function(_)
	sbar.trigger("swap_menus_and_spaces")
end)
