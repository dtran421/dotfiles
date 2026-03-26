---@type Colors
local colors = require("colors")
---@type Icons
local icons = require("icons")
---@type Settings
local settings = require("settings")

---@type table<string, string>
local app_icons = require("helpers.app_icons")

local EMPTY_SPACE_REGEX = "[^%s]+"
local NEWLINE_REGEX = "[^\r\n]+"
local AEROSPACE_WINDOW_REGEX = "|%s*.*%s*|"
local WINDOW_NAME_REGEX = "^%s*(.-)%s*|%s*.*%s*$"

---@type table<string, SbarItem>
local spaces = {}
---@type SbarItem?
Mode_indicator = nil

---@param windows string
---@return boolean has_app
---@return string workspace_icons
local get_space_icons = function(windows)
	local has_app = false
	local workspace_icons = ""

	for window in string.gmatch(windows, NEWLINE_REGEX) do
		has_app = true

		local app_match = string.match(window, AEROSPACE_WINDOW_REGEX)
		local app = string.gsub(string.sub(app_match, 2, #app_match - 1), WINDOW_NAME_REGEX, "%1")
		local trimmed_app = string.match(app, "^%s*(.-)%s*$")
		local lookup = app_icons[trimmed_app]
		local icon = lookup or app_icons["Default"]

		workspace_icons = workspace_icons .. " " .. icon
	end

	return has_app, workspace_icons
end

---@param workspace string
---@param workspace_icons string
local create_space = function(workspace, workspace_icons)
	if spaces[workspace] ~= nil then
		sbar.remove("space." .. workspace)
		sbar.remove("space.padding." .. workspace)
	end

	local space = sbar.add("space", "space." .. workspace, {
		space = workspace,
		icon = {
			font = {
				---@type string
				family = settings.font.text,
			},
			string = workspace,
			padding_left = 20,
			padding_right = 8,
			---@type number
			color = colors.white,
			---@type number
			highlight_color = colors.magenta,
		},
		label = {
			padding_right = 20,
			---@type number
			color = colors.grey,
			---@type number
			highlight_color = colors.white,
			font = "sketchybar-app-font:Regular:16.0",
			string = workspace_icons,
			y_offset = -1,
		},
		padding_right = 1,
		padding_left = 1,
		background = {
			---@type number
			color = colors.bg1,
			border_width = 1,
			height = 26,
		},
		popup = {
			background = {
				border_width = 5,
				---@type number
				border_color = colors.black,
			},
		},
	})

	-- Padding space
	sbar.add("space", "space.padding." .. workspace, {
		space = workspace,
		script = "",
		---@type number
		width = settings.group_paddings,
	})

	spaces[workspace] = space
end

---@param workspaces string
local create_spaces = function(workspaces)
	for workspace in string.gmatch(workspaces, EMPTY_SPACE_REGEX) do
		sbar.exec("aerospace list-windows --workspace " .. workspace, function(windows)
			local has_app, workspace_icons = get_space_icons(windows)

			if not has_app then
				return
			end

			create_space(workspace, workspace_icons)
		end)
	end
end

---@type SbarItem
local space_window_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

---@type SbarItem
local spaces_indicator = sbar.add("item", {
	---@type number
	padding_right = settings.group_paddings,
	icon = {
		padding_left = 8,
		padding_right = 8,
		color = colors.grey,
		string = icons.switch.on,
	},
	label = {
		width = 0,
		padding_left = 0,
		padding_right = 8,
		string = "Spaces",
		color = colors.grey,
	},
	background = {
		---@type number
		border_color = colors.with_alpha(colors.grey, 0.0),
		---@type number
		color = colors.with_alpha(colors.bg1, 0.0),
	},
})

---@param env table
local update_previous_workspace_handler = function(env)
	---@type string?
	local prev = env.PREVIOUS_WORKSPACE
	if prev == nil or not spaces[prev] then
		return
	end

	sbar.exec("aerospace list-windows --workspace " .. prev, function(windows)
		local has_app, workspace_icons = get_space_icons(windows)

		if not has_app then
			sbar.remove("space." .. prev)
			sbar.remove("space.padding." .. prev)
			spaces[prev] = nil
			return
		end

		sbar.animate("tanh", 5, function()
			spaces[prev]:set({
				icon = {
					font = {
						style = settings.font.style_map["Regular"],
					},
					highlight = false,
					color = colors.white,
					string = prev,
				},
				label = {
					highlight = false,
					string = workspace_icons,
				},
				background = {
					---@type number
					border_color = colors.bg2,
					border_width = 2,
				},
			})
		end)
	end)
end

---@param env table
local update_focused_workspace_handler = function(env)
	---@type string
	local focused = env.FOCUSED_WORKSPACE

	sbar.exec("aerospace list-windows --workspace " .. focused, function(windows)
		local _, workspace_icons = get_space_icons(windows)

		if spaces[focused] == nil then
			create_space(focused, workspace_icons)
		end

		sbar.animate("tanh", 5, function()
			spaces[focused]:set({
				drawing = true,
				icon = {
					highlight = true,
					font = {
						style = settings.font.style_map["Black"],
					},
					color = colors.magenta,
					string = "(" .. focused .. ")",
				},
				label = {
					highlight = true,
					string = workspace_icons,
				},
				background = {
					border_color = colors.magenta,
					border_width = 2,
				},
			})
		end)
	end)
end

space_window_observer:subscribe("aerospace_workspace_change", function(env)
	update_previous_workspace_handler(env)
	update_focused_workspace_handler(env)
end)

---@param env table
local update_mode_handler = function(env)
	if Mode_indicator == nil then
		return
	end

	local is_main = env.MODE == "main"
	Mode_indicator:set({
		icon = {
			string = is_main and (icons.aerospace and icons.aerospace.main or "")
				or (icons.aerospace and icons.aerospace.service or ""),
		},
		label = {
			string = string.upper(env.MODE),
		},
		background = {
			color = is_main and colors.blue or colors.green,
		},
	})
end

space_window_observer:subscribe("aerospace_mode_change", function(env)
	update_mode_handler(env)
end)

local setup_spaces = function()
	if Mode_indicator == nil then
		sbar.exec("aerospace list-modes --current", function(mode)
			Mode_indicator = sbar.add("item", "aerospace_mode", {
				icon = {
					padding_left = 16,
					padding_right = 8,
					font = {
						family = settings.font.text,
						style = settings.font.style_map["Bold"],
					},
					color = colors.bg1,
					string = icons.aerospace and icons.aerospace.main or "",
				},
				label = {
					padding_right = 16,
					font = {
						family = settings.font.text,
						style = settings.font.style_map["Black"],
					},
					color = colors.bg1,
					string = string.upper(mode),
				},
				background = {
					color = colors.blue,
					border_width = 1,
					height = 26,
				},
			})
		end)
	end

	sbar.exec("aerospace list-workspaces --all", function(workspaces)
		create_spaces(workspaces)

		sbar.exec("aerospace list-workspaces --focused", function(workspace)
			for focused_workspace in string.gmatch(workspace, EMPTY_SPACE_REGEX) do
				sbar.trigger("aerospace_workspace_change", { FOCUSED_WORKSPACE = focused_workspace })
			end
		end)
	end)
end

space_window_observer:subscribe("system_woke", function(_)
	setup_spaces()
end)

space_window_observer:subscribe("space_change", function(_)
	setup_spaces()
end)

spaces_indicator:subscribe("swap_menus_and_spaces", function(_)
	local currently_on = spaces_indicator:query().icon.value == icons.switch.on
	spaces_indicator:set({
		icon = currently_on and icons.switch.off or icons.switch.on,
	})
end)

spaces_indicator:subscribe("mouse.entered", function(_)
	sbar.animate("tanh", 30, function()
		spaces_indicator:set({
			background = {
				color = { alpha = 1.0 },
				border_color = { alpha = 1.0 },
			},
			label = { width = "dynamic" },
		})
	end)
end)

spaces_indicator:subscribe("mouse.exited", function(_)
	sbar.animate("tanh", 30, function()
		spaces_indicator:set({
			background = {
				color = { alpha = 0.0 },
				border_color = { alpha = 0.0 },
			},
			icon = {
				color = colors.grey,
			},
			label = { width = 0 },
		})
	end)
end)

spaces_indicator:subscribe("mouse.clicked", function(_)
	sbar.trigger("swap_menus_and_spaces")
end)
