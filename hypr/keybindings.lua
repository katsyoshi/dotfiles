-- Sway-compatible keybindings.
local terminal = "alacritty"
local menu = "wofi --show drun"
local main_mod = "SUPER"
local dotfiles = "/home/katsyoshi/Program/Github/dotfiles"

hl.bind(main_mod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(main_mod .. " + SHIFT + M", hl.dsp.exec_cmd(dotfiles .. "/bin/hypr-session-exit"))
hl.bind(main_mod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(main_mod .. " + SHIFT + D", hl.dsp.exec_cmd(dotfiles .. "/bin/wofi-run"))
hl.bind(main_mod .. " + G", hl.dsp.exec_cmd("LANG=ja_JP.utf8 wofi-window-switcher"))

local directions = {
  J = "left",
  K = "down",
  L = "up",
  semicolon = "right",
  left = "left",
  down = "down",
  up = "up",
  right = "right",
}

for key, direction in pairs(directions) do
  hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ direction = direction }))
  hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

-- Layout and window state.
hl.bind(main_mod .. " + SHIFT + H", hl.dsp.layout("preselect r"))
hl.bind(main_mod .. " + SHIFT + V", hl.dsp.layout("preselect d"))
hl.bind(main_mod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(main_mod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + space", hl.dsp.exec_cmd(dotfiles .. "/bin/hypr-focus-mode-toggle"))
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.group.toggle())
hl.bind(main_mod .. " + SHIFT + W", hl.dsp.group.toggle())
hl.bind(main_mod .. " + SHIFT + E", hl.dsp.layout("togglesplit"))

for i = 1, 10 do
  local key = i % 10
  hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(main_mod .. " + Tab", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(main_mod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(main_mod .. " + SHIFT + Y", hl.dsp.exec_cmd([[cliphist list | wofi --dmenu --pre-display-cmd "echo '%s' | cut -f 2" | cliphist decode | wl-copy]]))
hl.bind(main_mod .. " + T", hl.dsp.exec_cmd("LANG=ja_JP.utf8 wofi-window-switcher"))
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd("~/bin/wl-screen-shot"))

hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(main_mod .. " + SHIFT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + SHIFT + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Sway-compatible resize mode.
hl.bind(main_mod .. " + SHIFT + CTRL + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  local resize = {
    J = { x = -10, y = 0 },
    K = { x = 0, y = 10 },
    L = { x = 0, y = -10 },
    semicolon = { x = 10, y = 0 },
    left = { x = -10, y = 0 },
    down = { x = 0, y = 10 },
    up = { x = 0, y = -10 },
    right = { x = 10, y = 0 },
  }

  for key, delta in pairs(resize) do
    hl.bind(key, hl.dsp.window.resize({
      x = delta.x,
      y = delta.y,
      relative = true,
    }), { repeating = true })
  end

  hl.bind("Return", hl.dsp.submap("reset"))
  hl.bind("Escape", hl.dsp.submap("reset"))
end)
