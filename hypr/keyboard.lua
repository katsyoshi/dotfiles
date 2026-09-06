-- Keyboard layout and XKB options.
local is_omarchy = os.getenv("OMARCHY_PATH") ~= nil
local keyboard_layout = os.getenv("HYPR_KEYBOARD_LAYOUT") or (is_omarchy and "jp" or "us")
local keyboard_model = os.getenv("HYPR_KEYBOARD_MODEL") or (is_omarchy and "jp106" or "")
local keyboard_options = os.getenv("HYPR_KEYBOARD_OPTIONS") or (is_omarchy and "ctrl:nocaps" or "")

hl.config({
  input = {
    kb_layout = keyboard_layout,
    kb_variant = "",
    kb_model = keyboard_model,
    kb_options = keyboard_options,
    kb_rules = "",
  },
})

-- Portable keyboards send an ANSI/US key layout. Override the comma-separated
-- device list with HYPR_PORTABLE_KEYBOARD_NAMES when adding another keyboard.
local ansi_keyboard_names = os.getenv("HYPR_PORTABLE_KEYBOARD_NAMES")
  or "prk-firmware-developers-default-vid/pid-keyboard,xremap"
local ansi_layout = os.getenv("HYPR_PORTABLE_KEYBOARD_LAYOUT") or "us"
local ansi_model = os.getenv("HYPR_PORTABLE_KEYBOARD_MODEL") or ""
local ansi_options = os.getenv("HYPR_PORTABLE_KEYBOARD_OPTIONS") or "ctrl:nocaps"

for name in ansi_keyboard_names:gmatch("[^,]+") do
  name = name:match("^%s*(.-)%s*$")
  hl.device({
    name = name,
    kb_layout = ansi_layout,
    kb_variant = "",
    kb_model = ansi_model,
    kb_options = ansi_options,
    kb_rules = "",
  })
end
