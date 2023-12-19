local wezterm = require 'wezterm'
local os = require 'os'
local act = wezterm.action

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

wezterm.on(
   "format-tab-title",
   function(tab, _, _, _, hover, max_width)
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
   color_scheme = "Dracula (Official)",
   default_gui_startup_args = { "connect", "wezterm" },
   disable_default_key_bindings = true,
   font = wezterm.font "Noto Sans Mono CJK JP",
   font_size = 12,
   keys = {
      -- paste
      { key = "y", mods = "CTRL", action = act{ PasteFrom = "Clipboard" }, },
   },
   enable_tab_bar = false,
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
   },
   ssh_domains = ssh_domains,
}
