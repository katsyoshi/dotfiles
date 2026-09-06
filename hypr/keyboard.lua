-- Keyboard layout and XKB options.
local is_omarchy = os.getenv("OMARCHY_PATH") ~= nil

hl.config({
  input = {
    kb_layout = is_omarchy and "jp" or "us",
    kb_variant = "",
    kb_model = is_omarchy and "jp106" or "",
    kb_options = is_omarchy and "ctrl:nocaps" or "",
    kb_rules = "",
  },
})

-- The portable PRK keyboard sends an ANSI/US key layout. xremap exclusively
-- grabs this device, so its virtual keyboard needs the same override.
local ansi_keyboards = {
  "prk-firmware-developers-default-vid/pid-keyboard",
  "xremap",
}

for _, name in ipairs(ansi_keyboards) do
  hl.device({
    name = name,
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "ctrl:nocaps",
    kb_rules = "",
  })
end
