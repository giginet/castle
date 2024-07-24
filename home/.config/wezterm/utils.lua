local wezterm = require 'wezterm'

local module = {}

function module.is_start_with(str, prefix)
  return str.find(str, "^" .. prefix) ~= nil
end

local color_scheme = 'duskfox'
local scheme = wezterm.color.get_builtin_schemes()[color_scheme]

module.color_scheme = color_scheme

module.palette = {
  red = scheme.brights[2],
  green = scheme.brights[3],
  yellow = scheme.brights[4],
  blue = scheme.brights[5],
  purple = scheme.brights[6],
  cyan = scheme.brights[7],
  ivory = scheme.brights[8],
  background = scheme.background,
  cursor_bg = scheme.cursor_bg,
}

function module.concat(...)
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

function module.get_cwd(pane)
  local cwd = pane:get_current_working_dir()
  return module.format_path(cwd)
end

-- https://wezfurlong.org/wezterm/config/lua/window/set_right_status.html
function module.format_path(cwd_uri)
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

function module.replace_home_dir(cwd)
  return cwd:gsub(wezterm.home_dir, '~')
end

function module.get_basename(path)
    return string.match(path, "([^/]+)$")
end


function module.is_home_dir(cwd)
  return cwd == wezterm.home_dir
end

return module
