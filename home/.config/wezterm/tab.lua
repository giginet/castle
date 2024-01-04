local wezterm = require 'wezterm'
local utils = require 'utils'

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
  local pane = tab_info.active_pane

  local process_name = utils.get_basename(pane.foreground_process_name)

  if process_name == 'zsh' then
    local path = utils.format_path(pane.current_working_dir)
    if utils.is_home_dir(path) then
      return "󰋜"
    else
      return ' ' .. utils.get_basename(path)
    end
  end
  return '󱥸 ' .. process_name
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
      { Text = " " .. title .. " " },
    }
  end
)

return {}

