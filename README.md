# dotfiles

macOS (Apple Silicon) 環境の設定ファイル群。複数 Mac 間で共有・新規 Mac での再現を容易にする。

## Layout

GNU Stow パッケージ構成。`<package>/<path>` がそのまま `~/<path>` にミラーされる。

```
zsh/        .zshrc .zshenv .zprofile
bash/       .bashrc .bash_profile .bash_aliases
readline/   .inputrc
vim/        .vimrc .gvimrc .vim/dein.toml .vim/sc.vim
git/        .gitconfig .config/git/ignore
ghostty/    .config/ghostty/config
claude/     .claude/settings.json
gemini/     .gemini/GEMINI.md .gemini/settings.json
ansible/    playbook.yml hosts ansible.cfg update.sh
```

## Install (new Mac)

Apple Silicon Mac 限定。

```sh
git clone https://github.com/oikwsat/dotfiles.git
cd dotfiles
bash bootstrap.sh
```

`bootstrap.sh` は冪等で、Xcode CLT → Homebrew → `stow` + `ansible` 導入 → 各パッケージの stow → `ansible-playbook` を順に実行する。

## Update brew packages

```sh
bash ansible/update.sh
```

## Add a new package

1. パッケージディレクトリを作成 (例: `mkdir -p newapp/.config/newapp`)
2. 設定ファイルを置く
3. `bootstrap.sh` の `PACKAGES` 配列に追加
4. `stow -t "$HOME" newapp` で反映

## Notes

- secret は管理対象外。SSH 鍵、API key などは別途配置すること
- マシン固有分岐は持たない設計（全 Mac で同一構成）
- Intel Mac は非対応（`.zprofile` が `/opt/homebrew/bin/brew` をハードコード）
