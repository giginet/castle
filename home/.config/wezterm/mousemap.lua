wezterm = require 'wezterm'

-- Claude Code などマウスレポートを有効にする TUI の中では、既定の
-- CMD+クリックがアプリ側に奪われてリンクを開けない。mouse_reporting を
-- 有効にした割り当てを併記することで、TUI の内外どちらでも開けるようにする
return {
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    mouse_reporting = true,
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
  -- 押下イベントがアプリに渡ると選択やクリック扱いになるため握り潰す
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = wezterm.action.Nop,
  },
  {
    event = { Down = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    mouse_reporting = true,
    action = wezterm.action.Nop,
  },
}
