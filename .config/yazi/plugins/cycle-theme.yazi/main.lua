--- @sync entry
local function get_accents()
	return {
		"blue", "flamingo", "green", "lavender", "maroon", "mauve",
		"peach", "pink", "red", "rosewater", "sapphire", "sky", "teal", "yellow",
	}
end

local function get_state_file()
	return (os.getenv("HOME") or "") .. "/.config/yazi/.current-accent"
end

local function read_current()
	local f = io.open(get_state_file(), "r")
	if f then
		local accent = f:read("*l")
		f:close()
		return accent
	end
	return "mauve"
end

local function write_current(accent)
	local f = io.open(get_state_file(), "w")
	if f then
		f:write(accent)
		f:close()
	end
end

return {
	entry = function()
		local accents = get_accents()
		local current = read_current()

		-- Find next accent
		local idx = 1
		for i, a in ipairs(accents) do
			if a == current then
				idx = i + 1
				break
			end
		end
		if idx > #accents then idx = 1 end

		local next_accent = accents[idx]
		local themes_dir = (os.getenv("HOME") or "") .. "/.config/yazi/themes"
		local src = themes_dir .. "/catppuccin-mocha-" .. next_accent .. ".toml"
		local dst = (os.getenv("HOME") or "") .. "/.config/yazi/theme.toml"

		-- Copy theme file
		os.execute(string.format("cp '%s' '%s'", src, dst))
		write_current(next_accent)

		ya.notify {
			title = "Theme",
			content = "Switched to mocha " .. next_accent .. " (reopen yazi to apply)",
			timeout = 3,
		}
	end,
}
