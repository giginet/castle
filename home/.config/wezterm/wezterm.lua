local wezterm = require 'wezterm';
local config = {}

config.color_scheme = 'Dracula'

config.font = wezterm.font_with_fallback {
  { family = 'BitstromWera Nerd Font Mono' },
  { family = 'Hiragino Sans' },
}
config.font_size = 24
config.initial_cols = 160
config.initial_rows = 48

config.window_background_opacity = 0.8
config.text_background_opacity = 0.8

config.default_prog = { '/bin/zsh' }

config.default_cursor_style = 'BlinkingBlock'
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
    key = '|',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '_',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  {
    key = 'n',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'p',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = 'x',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  {
    key = 'f',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = 'r',
    mods = 'CMD',
    action = wezterm.action.ReloadConfiguration,
  },
  {
    key = 'L',
    mods = 'CTRL',
    action = wezterm.action.ShowDebugOverlay
  },
}

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = false
config.skip_close_confirmation_for_processes_named = { }

config.native_macos_fullscreen_mode = true

local status_renderer = require 'status'

wezterm.on('update-right-status', function(window, pane)
  status_renderer.render_right_status(window, pane)
end)

return config
