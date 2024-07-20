local wezterm = require 'wezterm';

local color_scheme = 'duskfox'
local scheme = wezterm.color.get_builtin_schemes()[color_scheme]
local background_color = wezterm.color.parse(scheme.background)

local config = {
  color_scheme = color_scheme,

  font = wezterm.font_with_fallback {
    { family = 'BitstromWera Nerd Font Mono' },
    { family = 'Hiragino Sans' },
    { family = 'SF Pro' },
  },
  font_size = 24,
  initial_cols = 120,
  initial_rows = 36,

  window_background_opacity = 0.95,
  text_background_opacity = 1,

  default_prog = { '/bin/zsh' },

  default_cursor_style = 'BlinkingBlock',
  window_padding = {
    left = 24,
    right = 0,
    top = 0,
    bottom = 0,
  },

  leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = require 'keymap',
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = false,
  show_new_tab_button_in_tab_bar = false,
  skip_close_confirmation_for_processes_named = { },
  tab_max_width = 64,

  native_macos_fullscreen_mode = true,
  window_background_gradient = {
    orientation = 'Vertical',
    colors = {
      background_color:darken(0.5),
      background_color,
      background_color:lighten(0.1),
    },
    interpolation = 'Linear',
    blend = 'Rgb',
  }
}

require 'status'
require 'tab'

return config
