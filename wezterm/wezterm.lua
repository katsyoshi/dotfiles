local wezterm = require 'wezterm'
local os = require 'os'
local act = wezterm.action
local mux = wezterm.mux
local dracula = require 'user.theme.dracula'
local ssh_domains = {
   {
      name = "rin",
      remote_address = "home",
      username = "katsyoshi",
   },
   {
      name = "sakra",
      remote_address = "sakra",
      username = "katsu",
   },
}

local base_dir = wezterm.home_dir .. "/.local/share/wezterm/"
local socket = base_dir .. "wezterm.socket"
local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)
local tmux_keybindings = require 'user.keybinds.tmux'

for i = 0, 9 do
   local key_string = tostring(i)
   table.insert(
      tmux_keybindings,
      {
         key = key_string,
         action = act.ActivateTab(i),
      }
   )
   table.insert(
      tmux_keybindings,
      {
         key = key_string,
         action = act.MoveTab(i),
      }
   )
   table.insert(
      tmux_keybindings,
      {
         key = key_string,
         action = act.ActivatePaneByIndex(i),
      }
   )
end

wezterm.on(
   "update-right-status",
   function(window, _)
      local date = wezterm.strftime("%Y/%m/%d(%a) %H:%M ");

      local bat = ""
      for _, b in ipairs(wezterm.battery_info()) do
         bat = "🔋 " .. string.format("%.0f%%", b.state_of_charge * 100)
      end

      window:set_right_status(
         wezterm.format(
            {
               { Background = { Color = "#2b2042", }, },
               { Foreground = { Color = "#808080", }, },
               { Text = bat .. "   "..date },
            }
         )
      );
end)

wezterm.on('mux-startup', function(cmd)
   local tab, pane, window = mux.spawn_window(cmd or {})
   pane:split { args = { "btm", } }
   pane:activate()
end)

return {
   adjust_window_size_when_changing_font_size = false,
   color_scheme = "Kanagawa (Gogh)",
   default_gui_startup_args = { "connect", "wezterm" },
   disable_default_key_bindings = true,
   font = wezterm.font "Noto Sans Mono CJK JP",
   font_size = 12,
   keys = require "user.keybinds.emacs",
   key_tables = {
      tmux_mode = tmux_keybindings,
   },
   enable_scroll_bar = true,
   enable_tab_bar = true,
   use_ime = true,
   tab_bar_at_bottom = true,
   term = "wezterm",

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
   },
   ssh_domains = ssh_domains,
}
