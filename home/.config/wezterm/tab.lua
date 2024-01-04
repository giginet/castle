
local wezterm = require 'wezterm'

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return title
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return tab_info.active_pane.title
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)

    local icon = ''
    if tab.is_active then
      icon = '󰓩'
    else
      icon = '󰓪'
    end

    return {
      { Text = " " .. icon .. " " .. title .. " " },
    }
  end
)

return {}

