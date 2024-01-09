wezterm = require 'wezterm'

return {
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
  {
    key = '-',
    mods = 'CTRL',
    action = wezterm.action.DisableDefaultAssignment,
  },
  {
    key = 'v',
    mods = 'LEADER',
    action = wezterm.action.ActivateCopyMode,
  },
}
