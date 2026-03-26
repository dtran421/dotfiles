---@type Settings
local settings = require("settings")

---@class Icons
---@field plus string
---@field loading string
---@field apple string
---@field gear string
---@field cpu string
---@field clipboard string
---@field switch { on: string, off: string }
---@field volume { _100: string, _66: string, _33: string, _10: string, _0: string }
---@field battery { _100: string, _75: string, _50: string, _25: string, _0: string, charging: string }
---@field wifi { upload: string, download: string, connected: string, disconnected: string, router: string }
---@field aerospace { main: string, service: string }
---@field media { back: string, forward: string, play_pause: string }

local icons = {
	sf_symbols = {
		plus = "􀅼",
		loading = "􀖇",
		apple = "􀣺",
		gear = "􀍟",
		cpu = "􀫥",
		clipboard = "􀉄",

		switch = {
			on = "􁏮",
			off = "􁏯",
		},
		volume = {
			_100 = "􀊩",
			_66 = "􀊧",
			_33 = "􀊥",
			_10 = "􀊡",
			_0 = "􀊣",
		},
		battery = {
			_100 = "􀛨",
			_75 = "􀺸",
			_50 = "􀺶",
			_25 = "􀛩",
			_0 = "􀛪",
			charging = "􀢋",
		},
		wifi = {
			upload = "􀄨",
			download = "􀄩",
			connected = "􀙇",
			disconnected = "􀙈",
			router = "􁓤",
		},
		aerospace = {
			main = "􀏅",
			service = "􀍟",
		},
		media = {
			back = "􀊊",
			forward = "􀊌",
			play_pause = "􀊈",
		},
	},

	-- Alternative NerdFont icons
	nerdfont = {
		plus = "",
		loading = "",
		apple = "",
		gear = "",
		cpu = "",
		clipboard = "􀉄",

		aerospace = {
			main = "",
			service = "",
		},
		switch = {
			on = "󱨥",
			off = "󱨦",
		},
		volume = {
			_100 = "",
			_66 = "",
			_33 = "",
			_10 = "",
			_0 = "",
		},
		battery = {
			_100 = "",
			_75 = "",
			_50 = "",
			_25 = "",
			_0 = "",
			charging = "",
		},
		wifi = {
			upload = "",
			download = "",
			connected = "󰖩",
			disconnected = "󰖪",
			router = "􁓤",
		},
		media = {
			back = "",
			forward = "",
			play_pause = "",
		},
	},
}

if not (settings.icons == "NerdFont") then
	return icons.sf_symbols --[[@as Icons]]
else
	return icons.nerdfont --[[@as Icons]]
end
