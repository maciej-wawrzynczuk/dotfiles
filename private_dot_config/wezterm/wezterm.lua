local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Tokyo Night Day'
config.font = wezterm.font('JetBrains Mono', {weight = 'Regular'})
config.initial_cols = 120
config.initial_rows = 30
config.enable_wayland = false

return config
