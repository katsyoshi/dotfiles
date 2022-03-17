local wezterm = require 'wezterm'
local os = require 'os'

local assign_keys = {
   -- emacs like keybindings
   { key = "c", mods = "LEADER", action = wezterm.action{ SpawnTab = "CurrentPaneDomain" }, },
   { key = "d", mods = "LEADER", action = wezterm.action{ CloseCurrentTab = { confirm = false }, }, },
   { key = "d", mods = "LEADER|CTRL", action = wezterm.action{ CloseCurrentPane = { confirm = false }, }, },
   { key = "[", mods = "LEADER", action = "ActivateCopyMode" },
   { key = "w", mods = "LEADER", action = wezterm.action{ CopyTo = "Clipboard" }, },
   { key = "y", mods = "LEADER", action = wezterm.action{ PasteFrom = "Clipboard" }, },
   { key = "n", mods = "LEADER", action = wezterm.action{ ActivateTabRelative = 1 }, },
   { key = "p", mods = "LEADER", action = wezterm.action{ ActivateTabRelative = -1 }, },
   { key = "'", mods = "LEADER|SHIFT", action = wezterm.action{ SplitVertical = { domain = "CurrentPaneDomain", }, }, },
   { key = "5", mods = "LEADER|SHIFT", action = wezterm.action{ SplitHorizontal = { domain = "CurrentPaneDomain", }, }, },
   { key = "o", mods = "LEADER", action = wezterm.action{ ActivatePaneDirection = "Next", }, },
}

for i = 1, 9 do
   table.insert(assign_keys,{
     key = tostring(i),
     mods = "LEADER",
     action = wezterm.action{ ActivateTab = i - 1 },
   })
   table.insert(assign_keys,{
     key = tostring(i),
     mods = "LEADER|CTRL",
     action = wezterm.action{ MoveTab = i - 1 },
   })
end

base_dir = wezterm.home_dir .. "/.local/share/wezterm/"
socket = base_dir .. "wezterm.socket"

return {
  font = wezterm.font"Noto Mono for Powerline",
  use_ime = true,
  font_size = 10.0,
  color_scheme = "Dracula",
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  disable_default_key_bindings = true,
  leader = { key="t", mods="CTRL", timeout_milliseconds=1000 },
  keys = assign_keys,
  tab_bar_at_bottom = true,
  unix_domains = {
    {
      name = "wezterm",
      socket_path = socket,
    },
    default_gui_startup_args = {"connect", "wezterm"},
  },
  daemon_options = {
    stdout = base_dir .. "stdout",
    stderr = base_dir .. "stderr",
    pid_file = base_dir .. "pid",
  }
}
