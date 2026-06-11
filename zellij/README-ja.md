# Zellij

## ファイル

- `config.kdl`: 通常用の Zellij 設定。
- `ai.kdl`: AI/Codex 用の設定。初期 layout に `layouts/ai.kdl` を使い、新規タブも AI layout で開く。
- `work.kdl`: 仕事用の設定。初期 layout に `layouts/work.kdl` を使うだけ。
- `layouts/newtab.kdl`: 通常 shell 用のタブ layout。
- `layouts/ai.kdl`: AI/Codex 用のタブ layout。
- `layouts/work.kdl`: 仕事用のタブ layout。

## コマンド

`../bin` の script を `PATH` 上のディレクトリへリンクする。
リンク名は手元で変えてよい。

```sh
ln -s /path/to/dotfiles/bin/zellij-ai ~/.local/bin/zellij-ai
ln -s /path/to/dotfiles/bin/zellij-work ~/.local/bin/zellij-work
ln -s /path/to/dotfiles/bin/zellij-newtab ~/.local/bin/zellij-newtab
```

### `zellij-ai`

`ai.kdl` を使って Zellij を起動する。

session 内で `zellij-newtab` を使うときの default も設定する。

- `ZELLIJ_NEWTAB_LAYOUT=ai`
- `ZELLIJ_NEWTAB_NAME=CODEX`

### `zellij-work`

`work.kdl` を使って Zellij を起動する。

### `zellij-newtab`

shell から新規タブを作る。

```sh
zellij-newtab
zellij-newtab CODEX:vaporware
zellij-newtab --name CODEX:vaporware --cwd ~/Program/Ruby/vaporware
zellij-newtab CODEX:vaporware -C ~/Program/Ruby/vaporware -- codex
zellij-newtab CODEX:vaporware -C ~/Program/Ruby/vaporware -- codex resume
```

default:

- layout: `ZELLIJ_NEWTAB_LAYOUT`、なければ `newtab`
- name: 明示した名前、位置引数の名前、`ZELLIJ_NEWTAB_NAME`、なければ cwd の basename
- cwd: `ZELLIJ_NEWTAB_CWD`、なければ現在のディレクトリ

## メモ

Zellij の keybind action は shell の環境変数を展開しない。
keybind 側の default を変えたい場合は、設定ファイルを分ける。
