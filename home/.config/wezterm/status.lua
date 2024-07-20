local wezterm = require 'wezterm'
local utils = require 'utils'

local function get_git_branch(repo)
  local success, stdout, stderr = wezterm.run_child_process { 'git', '-C', repo, 'rev-parse', '--abbrev-ref', 'HEAD' }
  if success then
    return stdout:gsub("\n$", "")
  else
    return nil
  end
end

local function make_dir_section(window, pane)
  local cwd = utils.get_cwd(pane)
  local is_home = utils.is_home_dir(cwd)

  if is_home then
    local icon = "󰋜"
    return {
      { Foreground = { Color = '#92aac7' } },
      { Text = icon },
    }
  else
    local display_cwd = utils.replace_home_dir(cwd)
    local icon = ""
    return {
      { Foreground = { Color = 'lightblue' } },
      { Text = icon },
      { Foreground = { Color = 'white' } },
      { Text = ' ' .. display_cwd },
    }
  end
end

local function make_git_info_section(window, pane)
  local cwd = utils.get_cwd(pane)
  local branch = get_git_branch(cwd)
  local icon = ''

  local elements = {
    { Foreground = { Color = 'orange' } },
    { Text = icon },
    { Foreground = { Color = 'white' } },
  }

  if branch then
    table.insert(elements, { Text = ' ' .. branch })
  else
    table.insert(elements, { Text = ' ' .. '-' })
  end
  return elements
end

local function make_edge_color(window)
  local leader_is_active = window:leader_is_active()
  local color_scheme_palette = wezterm.color.get_default_colors()
  local non_active = color_scheme_palette.brights[3] -- Green
  local active = color_scheme_palette.brights[4] -- Yellow
  if leader_is_active then
    return active
  else
    return non_active
  end
end

local function make_edge_elements(symbol, window)
  local color = make_edge_color(window) 
  return {
    { Foreground = { Color = color } },
    { Text = symbol },
  }
end

local function render_right_status(window, pane)
  local dir_section = make_dir_section(window, pane)
  local spacer = { { Text = '  ' } }
  local git_section = make_git_info_section(window, pane)
  local edge = make_edge_elements('', window)
  local elements = utils.concat(dir_section, spacer, git_section, spacer, edge)

  window:set_right_status(wezterm.format(elements))
end

wezterm.on('update-status', function(window, pane) 
  local color = make_edge_color(window)

  local elements = {
    { Background = { Color = color } },
    { Text = " " },
  }

  window:set_left_status(wezterm.format(elements))
end)


wezterm.on('update-right-status', function(window, pane)
  render_right_status(window, pane)
end)

