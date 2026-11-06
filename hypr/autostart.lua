-- Session environment and old Sway autostarts.
local terminal = "alacritty"
local dotfiles = "/home/katsyoshi/Program/Github/dotfiles"

hl.env("XCURSOR_THEME", "Adwaita")
hl.env("XCURSOR_SIZE", "16")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("SDL_IM_MODULE", "fcitx")

-- The start event can already have fired by the time Lua registers the
-- callback. Start Waybar while the configuration is being evaluated instead.
-- Do not let the foreground Waybar process block Hyprland's Lua config.
hl.exec_cmd(dotfiles .. "/bin/waybar-start >/tmp/waybar-start.log 2>&1 &")
-- xremap's wrapper is a long-running process; start it during config loading
-- so it does not depend on the hyprland.start callback timing.
hl.exec_cmd(dotfiles .. "/xremap/run >/tmp/xremap-start.log 2>&1 &")

hl.on("hyprland.start", function()
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd(dotfiles .. "/bin/hypr-session-start")
  hl.exec_cmd(terminal)
  hl.exec_cmd("discord")
  hl.exec_cmd("firefox-bin")
  hl.exec_cmd(dotfiles .. "/bin/fcitx5-start")
  hl.exec_cmd("mako -c ~/.config/mako/config.toml")
  hl.exec_cmd("remmina")
  hl.exec_cmd("wl-paste --watch cliphist store")
end)

hl.on("hyprland.shutdown", function()
  hl.exec_cmd("systemctl --user stop hyprland-session.target")
end)
