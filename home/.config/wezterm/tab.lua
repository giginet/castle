local wezterm = require 'wezterm'
local utils = require 'utils'

local function get_process_icon(process_name)
  if process_name == 'zsh' or process_name == 'bash' then
    return '󱆃'
  elseif process_name == 'nvim' then
    return ''
  elseif process_name == 'git' then
    return ''
  elseif process_name == 'ruby' then
    return ''
  elseif process_name == 'python' then
    return ''
  elseif utils.is_start_with(process_name, 'swift') then
    return ''
  elseif process_name == 'node' then
    return ''
  end
  return '󱥸'
end

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
  local process_icon = get_process_icon(process_name)
  return process_icon .. ' ' .. process_name
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

    local is_first_tab = tab_index == 1
    local is_last_tab = tab_index == #tabs

    local is_active = tab.is_active
    local is_next_active = false
    if not is_last_tab then
      is_next_active = tabs[tab_index + 1].is_active
    end

    local background_color = rainbows[color_index]
    local foreground_color = rainbows[color_index]:lighten(0.8)
    local next_background_color = rainbows[next_color_index]
    local intencity = "Normal"
    local elements = {}

    if is_active then
      background_color = rainbows[color_index]:darken(0.1)
      foreground_color = rainbows[color_index]:lighten(0.8)
      next_background_color = rainbows[next_color_index]:darken(0.5)
      intencity = "Bold" 
    else
      background_color = rainbows[color_index]:darken(0.5)
      foreground_color = rainbows[color_index]:lighten(0.2)

      if is_next_active then
        next_background_color = rainbows[next_color_index]:darken(0.1)
      else
        next_background_color = rainbows[next_color_index]:darken(0.5)
      end
      intencity = "Normal"
    end 

    if is_first_tab then
      elements = utils.concat(elements, {
        { Background = { Color =  'lightgreen' } },
        { Foreground = { Color = background_color } },
        { Text = "" },
      })
    end

    elements = utils.concat(elements, {
      { Background = { Color = background_color } },
      { Foreground = { Color = foreground_color } },
      { Attribute = { Intensity = intencity } },
      { Text = " " .. title .. " " },
    })

    if is_last_tab then
      elements = utils.concat(elements, {
        { Background = { Color = "clear" } },
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

