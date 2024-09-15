local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Dracula (Official)"

config.font = wezterm.font("Fira Code")
config.font_size = 18.0

return config
