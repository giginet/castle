-- Copy mode key bindings compatible with tmux's copy-mode-vi
local wezterm = require 'wezterm'
local act = wezterm.action

-- wezterm.gui is not available when the config is evaluated outside of the GUI
if not wezterm.gui then
  return {}
end

local copy_mode = wezterm.gui.default_key_tables().copy_mode

local function bind(entry)
  for i, existing in ipairs(copy_mode) do
    if existing.key == entry.key and (existing.mods or 'NONE') == (entry.mods or 'NONE') then
      copy_mode[i] = entry
      return
    end
  end
  table.insert(copy_mode, entry)
end

-- tmux: bind-key -T copy-mode-vi Enter send-keys -X copy-selection-and-cancel
bind {
  key = 'Enter',
  mods = 'NONE',
  action = act.Multiple {
    { CopyTo = 'ClipboardAndPrimarySelection' },
    { CopyMode = 'Close' },
  },
}

-- tmux: bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
bind {
  key = 'y',
  mods = 'NONE',
  action = act.Multiple {
    { CopyTo = 'Clipboard' },
    { CopyMode = 'Close' },
  },
}

return copy_mode
