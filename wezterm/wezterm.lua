local wezterm = require 'wezterm'
local os = require 'os'
local act = wezterm.action

local nvtop = { domain = "CurrentPaneDomain", args = {"nvtop"}, }
local htop =  { domain = "CurrentPaneDomain", args = {"htop"}, }
local cursols = {
   { key = "Enter", mods = "CTRL", action = act.CopyMode { SetSelectionMode = "Block" }, },
   { key = "Escape", mods = "NONE", action = act.CopyMode "Close", },
   { key = "a", mods = "CTRL", action = act.CopyMode "MoveToStartOfLineContent" },
   { key = "b", mods = "ALT", action = act.CopyMode "MoveBackwardWord", },
   { key = "b", mods = "CTRL", action = act.CopyMode "MoveLeft", },
   { key = "e", mods = "CTRL", action = act.CopyMode "MoveToEndOfLineContent" },
   { key = "f", mods = "ALT", action = act.CopyMode "MoveForwardWord", },
   { key = "f", mods = "CTRL", action = act.CopyMode "MoveRight", },
   { key = "g", mods = "CTRL", action = act.CopyMode "Close", },
   { key = "p", mods = "CTRL", action = act.CopyMode "MoveUp", },
   { key = "p", mods = "ALT", action = act.CopyMode "PageUp", },
   { key = "n", mods = "CTRL", action = act.CopyMode "MoveDown", },
   { key = "n", mods = "ALT", action = act.CopyMode "PageDown", },
   { key = "q", mods = "NONE", action = act.CopyMode "Close", },
   { key = "Space", mods = "NONE", action = act.CopyMode { SetSelectionMode = "Cell" }, },
}
local assigned_keys = {
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
   { key = "r", mods = "LEADER", action = "ReloadConfiguration", },
   { key = "r", mods = "LEADER|CTRL", action = wezterm.action{ SplitHorizontal = nvtop }, },
   { key = "r", mods = "LEADER|SHIFT", action = wezterm.action{ SplitVertical = htop }, },
   { key = "=", mods = "LEADER|SUPER", action = "IncreaseFontSize", },
   { key = "-", mods = "LEADER|SUPER", action = "DecreaseFontSize", },
   { key = "r", mods = "LEADER|SUPER", action = "ResetFontSize", },
}

for i = 0, 9 do
   local key_string = tostring(i)
   table.insert(assigned_keys,{
     key = key_string,
     mods = "LEADER|ALT",
     action = wezterm.action{ ActivateTab = i },
   })
   table.insert(assigned_keys,{
     key = key_string,
     mods = "LEADER|CTRL",
     action = wezterm.action{ MoveTab = i },
   })
   table.insert(assigned_keys,{
     key = key_string,
     mods = "LEADER",
     action = wezterm.action{ ActivatePaneByIndex = i },
   })
end

local base_dir = wezterm.home_dir .. "/.local/share/wezterm/"
local socket = base_dir .. "wezterm.socket"

local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

wezterm.on("update-right-status", function(window, _)
  local date = wezterm.strftime("%Y/%m/%d(%a) %H:%M ");

  local bat = ""

  for _, b in ipairs(wezterm.battery_info()) do
    bat = "🔋 " .. string.format("%.0f%%", b.state_of_charge * 100)
  end

  window:set_right_status(wezterm.format({
    { Background = { Color = "#2b2042", }, },
    { Foreground = { Color = "#808080", }, },
    { Text = bat .. "   "..date },
  }));
end)

wezterm.on("format-tab-title", function(tab, _, _, _, hover, max_width)
  local edge_background = "#0b0022"
  local background = "#1b1032"
  local foreground = "#808080"

  if tab.is_active then
    background = "#2b2042"
    foreground = "#c0c0c0"
  elseif hover then
    background = "#3b3052"
    foreground = "#909090"
  end

  local edge_foreground = background

  -- ensure that the titles fit in the available space,
  -- and that we have room for the edges.
  local title = wezterm.truncate_right(tab.active_pane.title, max_width-2)

  return {
    { Background = { Color = edge_background }, },
    { Foreground = { Color = edge_foreground }, },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background, }, },
    { Foreground = { Color = foreground, }, },
    { Text = title },
    { Background = { Color = edge_background, }, },
    { Foreground = { Color = edge_foreground, }, },
    { Text = SOLID_RIGHT_ARROW, },
  }
end)

return {
  adjust_window_size_when_changing_font_size = false,
  color_scheme = "Dracula",
  default_gui_startup_args = { "connect", "wezterm" },
  disable_default_key_bindings = true,
  font = wezterm.font"Noto Mono for Powerline",
  font_size = 10.0,
  keys = assigned_keys,
  key_tables = {
     copy_mode = cursols,
  },
  leader = { key="t", mods="CTRL", timeout_milliseconds=1000 },
  tab_bar_at_bottom = true,
  use_ime = true,

  unix_domains = {
    {
      name = "wezterm",
      socket_path = socket,
    },
  },
  daemon_options = {
    stdout = base_dir .. "stdout",
    stderr = base_dir .. "stderr",
    pid_file = base_dir .. "pid",
  }
}
