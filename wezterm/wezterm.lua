local wezterm = require 'wezterm';

local assign_keys = {
   { key = "c", mods = "LEADER", action = wezterm.action{ SpawnTab = "CurrentPaneDomain" }, },
   { key = "[", mods = "LEADER", action = "ActivateCopyMode" },
   { key = "w", mods = "LEADER", action = wezterm.action{ CopyTo = "Clipboard" }, },
   { key = "y", mods = "LEADER", action = wezterm.action{ PasteFrom = "Clipboard" }, },
   { key = "n", mods = "LEADER", action = wezterm.action{ ActivateTabRelative = -1 }, },
   { key = "p", mods = "LEADER", action = wezterm.action{ ActivateTabRelative = 1 }, },
   { key = "5", mods = "LEADER|SHIFT", action = wezterm.action{ SplitVertical = { domain = "CurrentPaneDomain", }, }, },
   { key = "'", mods = "LEADER|SHIFT", action = wezterm.action{ SplitHorizontal = { domain = "CurrentPaneDomain", }, }, },
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

return {
  font = wezterm.font("Noto Mono for Powerline"),
  use_ime = true,
  font_size = 10.0,
  color_scheme = "Dracula",
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  disable_default_key_bindings = true,
  leader = { key="t", mods="CTRL", timeout_milliseconds=1000 },
  keys = assign_keys,
}
