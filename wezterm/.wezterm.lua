local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"

config.font = wezterm.font_with_fallback({ "Fira Code Nerd Font", "Fira Code" })
config.font_size = 12.0

config.use_fancy_tab_bar = false

return config
