local wezterm = require 'wezterm';

return {
  font = wezterm.font("Noto Mono for Powerline"),
  use_ime = true,
  font_size = 10.0,
  color_scheme = "Dracula",
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  disable_default_key_bindings = true,
}
