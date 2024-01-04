local wezterm = require 'wezterm';
local config = {
  color_scheme = 'Tokyo Night',

  font = wezterm.font_with_fallback {
    { family = 'BitstromWera Nerd Font Mono' },
    { family = 'Hiragino Sans' },
  },
  font_size = 24,
  initial_cols = 160,
  initial_rows = 48,

  window_background_opacity = 0.8,
  text_background_opacity = 0.8,

  default_prog = { '/bin/zsh' },

  default_cursor_style = 'BlinkingBlock',
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 },
  keys = require 'keymap',
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = false,
  skip_close_confirmation_for_processes_named = { },

  native_macos_fullscreen_mode = true,
}

require 'status'
require 'tab'

return config
