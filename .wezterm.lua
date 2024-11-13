-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font = wezterm.font 'FiraCode Nerd Font'
config.font_size = 15

config.adjust_window_size_when_changing_font_size = false

-- Disable tab bar
config.enable_tab_bar = false

-- 颜色配置
config.colors = {
  foreground = "#b3b3b3",  -- Alacritty中的primary.foreground
  background = "#000000",  -- Alacritty中的primary.background
  cursor_bg = "#ffffff",   -- Alacritty中的cursor.cursor
  cursor_fg = "#000000",   -- Alacritty中的cursor.text
  cursor_border = "#ffffff", -- 设置光标边框颜色
  selection_bg = "#4c52f8", -- Alacritty中的selection.background
  selection_fg = "#000000", -- Alacritty中的selection.text
  ansi = {
    "#000000",  -- black (color0)
    "#cc5555",  -- red (color1)
    "#55cc55",  -- green (color2)
    "#cdcd55",  -- yellow (color3)
    "#5455cb",  -- blue (color4)
    "#cc55cc",  -- magenta (color5)
    "#7acaca",  -- cyan (color6)
    "#cccccc",  -- white (color7)
  },
  brights = {
    "#555555",  -- bright black (color8)
    "#ff5555",  -- bright red (color9)
    "#55ff55",  -- bright green (color10)
    "#ffff55",  -- bright yellow (color11)
    "#5555ff",  -- bright blue (color12)
    "#ff55ff",  -- bright magenta (color13)
    "#55ffff",  -- bright cyan (color14)
    "#ffffff",  -- bright white (color15)
  },
}

-- and finally, return the configuration to wezterm
return config

