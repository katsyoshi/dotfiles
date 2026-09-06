-- Match the old Sway workspace names.
local workspace_names = {
  "1: Work",
  "2: Web",
  "3: SNS",
  "4: Graphics",
  "5: Audio Visual",
  "6: Database",
  "7: Game",
  "8: IDE",
  "9: FREESPACE",
  "10: freespace",
}

for i, name in ipairs(workspace_names) do
  hl.workspace_rule({ workspace = tostring(i), default_name = name })
end

-- Match the old Sway application placement.
local function place(name, class, workspace)
  hl.window_rule({
    name = name,
    match = { class = class },
    workspace = tostring(workspace) .. " silent",
  })
end

place("terminals-on-workspace-1", "(Alacritty|emacs|footclient)", 1)
place("firefox-on-workspace-2", "(firefox|firefox-bin)", 2)
place("chat-on-workspace-3", "(slack|Slack|discord)", 3)
place("graphics-on-workspace-4", "(org[.]gnome[.]Evince|geeqie|Gimp|gimp|org[.]inkscape[.]Inkscape|darktable)", 4)
place("media-on-workspace-5", "(deadbeef|org[.]remmina[.]Remmina|com[.]obsproject[.]Studio)", 5)
place("android-studio-on-workspace-8", "jetbrains-studio", 8)

hl.window_rule({
  name = "float-imv",
  match = { class = "imv" },
  float = true,
  center = true,
})
hl.window_rule({
  name = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})
