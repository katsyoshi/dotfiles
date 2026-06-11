# Zellij

## Files

- `config.kdl`: default Zellij config.
- `ai.kdl`: AI/Codex config. It uses `layouts/ai.kdl` as the default layout and opens new tabs with the AI layout.
- `work.kdl`: work config. It only selects `layouts/work.kdl` as the default layout.
- `layouts/newtab.kdl`: normal shell tab layout.
- `layouts/ai.kdl`: AI/Codex tab layout.
- `layouts/work.kdl`: work tab layout.

## Commands

Link the scripts in `../bin` to a directory on `PATH`.
The link name can be changed locally.

```sh
ln -s /path/to/dotfiles/bin/zellij-ai ~/.local/bin/zellij-ai
ln -s /path/to/dotfiles/bin/zellij-work ~/.local/bin/zellij-work
ln -s /path/to/dotfiles/bin/zellij-newtab ~/.local/bin/zellij-newtab
```

### `zellij-ai`

Starts Zellij with `ai.kdl`.

It also sets these defaults for `zellij-newtab` inside the session:

- `ZELLIJ_NEWTAB_LAYOUT=ai`
- `ZELLIJ_NEWTAB_NAME=CODEX`

### `zellij-work`

Starts Zellij with `work.kdl`.

### `zellij-newtab`

Creates a new tab from the shell.

```sh
zellij-newtab
zellij-newtab CODEX:vaporware
zellij-newtab --name CODEX:vaporware --cwd ~/Program/Ruby/vaporware
zellij-newtab CODEX:vaporware -C ~/Program/Ruby/vaporware -- codex
zellij-newtab CODEX:vaporware -C ~/Program/Ruby/vaporware -- codex resume
```

Defaults:

- layout: `ZELLIJ_NEWTAB_LAYOUT`, or `newtab`
- name: explicit name, positional name, `ZELLIJ_NEWTAB_NAME`, or the cwd basename
- cwd: `ZELLIJ_NEWTAB_CWD`, or the current directory

## Notes

Zellij keybind actions do not expand shell environment variables.
Use a separate config file when keybinds need different defaults.
