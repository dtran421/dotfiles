local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

local battery = sbar.add("item", "widgets.battery", {
	position = "right",
	icon = {
		font = {
			---@type string
			style = settings.font.style_map["Regular"],
			size = 19.0,
		},
	},
	label = {
		font = {
			---@type string
			family = settings.font.numbers,
		},
	},
	update_freq = 180,
	popup = { align = "center" },
})

local remaining_time = sbar.add("item", {
	position = "popup." .. battery.name,
	icon = {
		string = "Time remaining:",
		width = 100,
		align = "left",
	},
	label = {
		string = "??:??h",
		width = 100,
		align = "right",
	},
})

battery:subscribe({ "routine", "power_source_change", "system_woke" }, function()
	sbar.exec("pmset -g batt", function(batt_info)
		local icon = "!"
		local label = "?"

		---@type boolean, unknown, number?
		local found, _, charge = batt_info:find("(%d+)%%")
		if found then
			charge = tonumber(charge)
			label = charge .. "%"
		end

		---@type number
		local color = colors.green
		---@type boolean, unknown, unknown
		local charging, _, _ = batt_info:find("AC Power")

		if charging then
			---@type string
			icon = icons.battery.charging
		else
			if found and charge > 80 then
				---@type string
				icon = icons.battery._100
			elseif found and charge > 60 then
				---@type string
				icon = icons.battery._75
			elseif found and charge > 40 then
				---@type string
				icon = icons.battery._50
			elseif found and charge > 20 then
				---@type string
				icon = icons.battery._25
				---@type number
				color = colors.orange
			else
				---@type string
				icon = icons.battery._0
				---@type number
				color = colors.red
			end
		end

		battery:set({
			icon = {
				string = icon,
				color = color,
			},
			label = { string = label },
		})
	end)
end)

battery:subscribe("mouse.clicked", function(_)
	---@type "off" | "on"
	local drawing = battery:query().popup.drawing
	battery:set({ popup = { drawing = "toggle" } })

	if drawing == "off" then
		sbar.exec("pmset -g batt", function(batt_info)
			---@type boolean, unknown, number
			local found, _, remaining = batt_info:find(" (%d+:%d+) remaining")
			local label = found and remaining .. "h" or "No estimate"
			remaining_time:set({ label = label })
		end)
	end
end)

local function hide_details()
	battery:set({ popup = { drawing = false } })
end

battery:subscribe("mouse.exited.global", hide_details)
sbar.add("bracket", "widgets.battery.bracket", { battery.name }, {
	background = {
		---@type number
		color = colors.bg1,
	},
})

sbar.add("item", "widgets.battery.padding", {
	position = "right",
	---@type number
	width = settings.group_paddings,
})
