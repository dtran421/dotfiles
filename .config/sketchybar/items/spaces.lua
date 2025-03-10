local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

---@type table<string, string>
local app_icons = require("helpers.app_icons")

local EMPTY_SPACE_REGEX = "[^%s]+"
local NEWLINE_REGEX = "[^\r\n]+"
local AEROSPACE_WINDOW_REGEX = "|%s*.*%s*|"
local WINDOW_NAME_REGEX = "^%s*(.-)%s*|%s*.*%s*$"

local spaces = {}
Mode_indicator = nil

local trim = function(s)
	local l = 1
	while string.sub(s, l, l) == " " do
		l = l + 1
	end

	local r = #s
	while string.sub(s, r, r) == " " do
		r = r - 1
	end
	return string.sub(s, l, r)
end

local get_space_icons = function(windows)
	local has_app = false
	local workspace_icons = ""

	for window in string.gmatch(windows, NEWLINE_REGEX) do
		has_app = true

		local app_match = string.match(window, AEROSPACE_WINDOW_REGEX)
		local app = string.gsub(string.sub(app_match, 2, #app_match - 1), WINDOW_NAME_REGEX, "%1")

		local trimmed_app = trim(app)
		local lookup = app_icons[trimmed_app]
		local icon = ((lookup == nil) and app_icons["Default"] or lookup)

		workspace_icons = workspace_icons .. " " .. icon
	end

	return has_app, workspace_icons
end

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

local space_window_observer = sbar.add("item", {
	drawing = false,
	updates = true,
})

local spaces_indicator = sbar.add("item", {
	---@type number
	padding_right = settings.group_paddings,
	icon = {
		padding_left = 8,
		padding_right = 8,
		---@type number
		color = colors.grey,
		---@type number
		string = icons.switch.on,
	},
	label = {
		width = 0,
		padding_left = 0,
		padding_right = 8,
		string = "Spaces",
		---@type number
		color = colors.grey,
	},
	background = {
		---@type number
		border_color = colors.with_alpha(colors.grey, 0.0),
		---@type number
		color = colors.with_alpha(colors.bg1, 0.0),
	},
})

local update_previous_workspace_handler = function(env)
	if env.PREVIOUS_WORKSPACE == nil or not spaces[env.PREVIOUS_WORKSPACE] then
		return
	end

	sbar.exec("aerospace list-windows --workspace " .. env.PREVIOUS_WORKSPACE, function(windows)
		local has_app, _ = get_space_icons(windows)

		if not has_app then
			spaces[env.PREVIOUS_WORKSPACE]:set({
				drawing = false,
			})
			return
		end

		sbar.animate("tanh", 5, function()
			spaces[env.PREVIOUS_WORKSPACE]:set({
				icon = {
					font = {
						---@type string
						style = settings.font.style_map["Regular"],
					},
					highlight = false,
					---@type number
					color = colors.white,
					---@type string
					string = env.PREVIOUS_WORKSPACE,
				},
				label = {
					highlight = false,
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

local update_focused_workspace_handler = function(env)
	sbar.exec("aerospace list-windows --workspace " .. env.FOCUSED_WORKSPACE, function(windows)
		local _, workspace_icons = get_space_icons(windows)

		if spaces[env.FOCUSED_WORKSPACE] == nil then
			create_space(env.FOCUSED_WORKSPACE, workspace_icons)
		end

		sbar.animate("tanh", 5, function()
			spaces[env.FOCUSED_WORKSPACE]:set({
				drawing = true,
				icon = {
					highlight = true,
					font = {
						---@type string
						style = settings.font.style_map["Black"],
					},
					---@type number
					color = colors.magenta,
					string = "(" .. env.FOCUSED_WORKSPACE .. ")",
				},
				label = {
					highlight = true,
					string = workspace_icons,
				},
				background = {
					---@type number
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

local update_mode_handler = function(env)
	if Mode_indicator == nil then
		return
	end

	Mode_indicator:set({
		icon = {
			---@type string
			string = env.MODE == "main" and icons.aerospace.main or icons.aerospace.service,
		},
		label = {
			string = string.upper(env.MODE),
		},
		background = {
			---@type number
			color = env.MODE == "main" and colors.blue or colors.green,
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
						---@type string
						family = settings.font.text,
						---@type string
						style = settings.font.style_map["Bold"],
					},
					---@type number
					color = colors.bg1,
					---@type string
					string = icons.aerospace.main,
				},
				label = {
					padding_right = 16,
					font = {
						---@type string
						family = settings.font.text,
						---@type string
						style = settings.font.style_map["Black"],
					},
					---@type number
					color = colors.bg1,
					string = string.upper(mode),
				},
				background = {
					---@type number
					color = colors.blue,
					border_width = 1,
					height = 26,
				},
			})
		end)
	end

	sbar.exec("aerospace list-workspaces --all", function(workspaces)
		create_spaces(workspaces, true)

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
		---@type string
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
				---@type number
				color = colors.grey,
			},
			label = { width = 0 },
		})
	end)
end)

spaces_indicator:subscribe("mouse.clicked", function(env)
	sbar.trigger("swap_menus_and_spaces")
end)
