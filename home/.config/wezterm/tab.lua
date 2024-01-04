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
    
    local color_index = ((tab_index - 1) % #rainbows) + 1
    local next_color_index = (tab_index % #rainbows) + 1

    local is_active = tab.is_active

    local background_color = rainbows[color_index]
    local foreground_color = rainbows[color_index]:lighten(0.8)
    local next_background_color = rainbows[next_color_index]
    local intencity = "Normal"

    local is_first_tab = tab_index == 1
    local is_last_tab = tab_index == #tabs

    local elements = {}

    if is_active then
      background_color = rainbows[color_index]:darken(0.1)
      foreground_color = rainbows[color_index]:lighten(0.8)
      next_background_color = rainbows[next_color_index]:darken(0.1)
      intencity = "Bold" 
    else
      background_color = rainbows[color_index]:darken(0.1)
      foreground_color = rainbows[color_index]:lighten(0.8)
      next_background_color = rainbows[next_color_index]:darken(0.1)
      intencity = "Normal"
    end 

    if is_first_tab then
      print(tab)
      -- local edge_color = utils.make_edge_color(pane.window)
      elements = utils.concat(elements, {
        { Background = { Color =  'lightgreen' } },
        { Foreground = { Color = background_color } },
        { Text = "" },
      })
    end

    elements = utils.concat(elements, {
      { Background = { Color = background_color } },
      { Foreground = { Color = foreground_color } },
      { Text = " " .. title .. " " },
      { Attribute = { Intensity = intencity } },
    })

    if is_last_tab then
      elements = utils.concat(elements, {
        { Background = { Color = "black" } },
        { Foreground = { Color = background_color } },
        { Text = "" },
      })
    else
      elements = utils.concat(elements, {
        { Background = { Color = next_background_color } },
        { Foreground = { Color = background_color } },
        { Text = "" },
      })
    end

    return elements
  end
)

return {}

