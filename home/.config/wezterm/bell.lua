local wezterm = require 'wezterm'

local module = {}

-- Track which tabs have unread bell notifications
local bell_tabs = {}

function module.has_bell(tab_id)
  return bell_tabs[tab_id] == true
end

function module.clear_bell(tab_id)
  bell_tabs[tab_id] = nil
end

wezterm.on('bell', function(window, pane)
  local tab = pane:tab()
  if not tab then
    return
  end

  local tab_id = tab:tab_id()
  local active_tab = window:active_tab()

  -- Only mark if the tab is not currently active
  if active_tab:tab_id() ~= tab_id then
    bell_tabs[tab_id] = true
  end
end)

return module
