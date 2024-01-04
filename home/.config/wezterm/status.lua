local wezterm = require 'wezterm'

-- https://wezfurlong.org/wezterm/config/lua/window/set_right_status.html
local function get_cwd(pane)
  local cwd_uri = pane:get_current_working_dir()
  local cwd = ''

  if type(cwd_uri) == 'userdata' then
    -- Running on a newer version of wezterm and we have
    -- a URL object here, making this simple!

    cwd = cwd_uri.file_path
  else
    -- an older version of wezterm, 20230712-072601-f4abf8fd or earlier,
    -- which doesn't have the Url object
    cwd_uri = cwd_uri:sub(8)
    local slash = cwd_uri:find '/'
    if slash then
      cwd = cwd_uri:sub(slash):gsub('%%(%x%x)', function(hex)
        return string.char(tonumber(hex, 16))
      end)
    end
  end
  return cwd
end

local function is_home_dir(cwd)
  return cwd == wezterm.home_dir
end

local function get_git_branch(repo)
  local success, stdout, stderr = wezterm.run_child_process { 'git', '-C', repo, 'rev-parse', '--abbrev-ref', 'HEAD' }
  if success then
    return stdout:gsub("\n$", "")
  else
    return nil
  end
end

local function replace_home_dir(cwd)
  return cwd:gsub(wezterm.home_dir, '~')
end

local function make_dir_section(window, pane)
  local cwd = get_cwd(pane)
  local is_home = is_home_dir(cwd)

  if is_home then
    local icon = "󰋜"
    return {
      { Foreground = { Color = '#92aac7' } },
      { Text = icon },
    }
  else
    local display_cwd = replace_home_dir(cwd)
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
  local cwd = get_cwd(pane)
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

local function concat(...)
    local res = {}
    local inputs = {...}

    for _, tbl in ipairs(inputs) do
        if type(tbl) == 'table' then
            for _, v in ipairs(tbl) do
                table.insert(res, v)
            end
        end
    end

    return res
end

local function make_edge_elements(symbol, window)
  local leader_is_active = window:leader_is_active()
  local color = 'lightgreen'
  if leader_is_active then
    color = 'yellow'
  else
    color = 'lightgreen'
  end

  return {
    { Foreground = { Color = color } },
    { Text = symbol },
  }
end

function render_right_status(window, pane)
  local dir_section = make_dir_section(window, pane)
  local spacer = { { Text = '  ' } }
  local git_section = make_git_info_section(window, pane)
  local edge = make_edge_elements('', window)
  local elements = concat(dir_section, spacer, git_section, spacer, edge)

  window:set_right_status(wezterm.format(elements))
end

wezterm.on('update-status', function(window, pane) 
  local edge = make_edge_elements('', window)

  local elements = edge

  window:set_left_status(wezterm.format(elements))
end)


wezterm.on('update-right-status', function(window, pane)
  render_right_status(window, pane)
end)

