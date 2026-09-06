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

hl.on("hyprland.start", function()
  hl.exec_cmd("waybar -c ~/.config/waybar/config-hyprland -s ~/.config/waybar/style.css")
  hl.exec_cmd(dotfiles .. "/bin/hypr-session-start")
  hl.exec_cmd(terminal)
  hl.exec_cmd("discord")
  hl.exec_cmd("firefox-bin")
  hl.exec_cmd("fcitx5 -d")
  hl.exec_cmd("mako -c ~/.config/mako/config.toml")
  hl.exec_cmd("remmina")
  hl.exec_cmd("~/.config/xremap/run")
  hl.exec_cmd("wl-paste --watch cliphist store")
end)

hl.on("hyprland.shutdown", function()
  hl.exec_cmd("systemctl --user stop hyprland-session.target")
end)
