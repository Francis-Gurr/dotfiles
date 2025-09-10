local wezterm = require("wezterm")

wezterm.on("format-tab-title", function(tab)
	-- Get the process name (e.g., zsh, nvim, node)
	local process_name = tab.active_pane.foreground_process_name
	print("TAB", tab)
	if process_name then
		-- Get only the last part of the path (e.g., "zsh" instead of "/usr/bin/zsh")
		process_name = process_name:match("[^/]+$")
	end

	-- Get the current working directory (CWD)
	local cwd_uri = tab.active_pane.current_working_dir
	print("CWD URI: ", cwd_uri) -- This will print the current working directory URI
	local cwd = ""
	if cwd_uri then
		-- Remove the "file://" prefix and keep only the last directory
		cwd = tostring(cwd_uri):match("([^/]+)/*$") or cwd_uri
	end

	-- Combine process name and directory into the tab title
	local title = string.format(" %s: %s - %s ", tab.tab_index + 1, cwd, process_name)
	-- if cwd ~= "" then
	-- 	title = title .. " — " .. cwd
	-- end

	return title
end)

local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"

config.font = wezterm.font_with_fallback({ "Fira Code Nerd Font", "FiraCode Nerd Font" })
config.font_size = 12.0

config.use_fancy_tab_bar = false
config.tab_max_width = 50

config.keys = {
	-- Map bare AltGr (RightAlt) to send Ctrl-b (tmux leader)
	{ key = "RightAlt", mods = "NONE", action = wezterm.action({ SendString = "\x02" }) },
}

return config
