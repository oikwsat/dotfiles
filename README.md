# dotfiles

macOS 環境の設定ファイル群

## Description

マルチ環境でも環境構築できるように，アプリの設定・手順を自動化する

## Content

- dot files
  - bash
  - vim
  - zsh
- installer
  - brew + ansible

## Install

```
% git clone
% cd dotfiles/apps
% sh install.sh
```

## create symbolic links

```
% cd ~
% ln -s dotfiles/_zshrc .zshrc
% ln -s dotfiles/_zshenv .zshenv
```

## Update

```
$ brew cleanup
$ brew install --force $(brew list)
```
