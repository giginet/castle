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

local function get_tab_index(tabs, tab)
    for index, v in ipairs(tabs) do
        if v.tab_id == tab.tab_id then
            return index
        end
    end
    return nil
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local title = tab_title(tab)
    local rainbows = wezterm.color.gradient({preset="Cool"}, 8)

    local tab_index = get_tab_index(tabs, tab)
    
    local color_index = tab_index % #rainbows

    local is_active = tab.is_active

    local background_color = rainbows[color_index]
    local foreground_color = rainbows[color_index]:lighten(0.8)
    if is_active then
      background_color = rainbows[color_index]:darken(0.1)
      foreground_color = rainbows[color_index]:lighten(0.8)

      return {
        { Background = { Color = background_color } },
        { Foreground = { Color = foreground_color } },
        { Attribute = { Intensity = "Bold" } },
        { Text = " " .. title .. " " },
      }
    else
      background_color = rainbows[color_index]:darken(0.1):desaturate(0.5)
      foreground_color = rainbows[color_index]:lighten(0.8)

      return {
        { Background = { Color = background_color } },
        { Foreground = { Color = foreground_color } },
        { Text = " " .. title .. " " },
      }
    end
  end
)

return {}

