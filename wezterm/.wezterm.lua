local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Dracula (Official)"

config.font = wezterm.font("Fira Code Nerd Font")
config.font_size = 12.0

config.use_fancy_tab_bar = false

return config
