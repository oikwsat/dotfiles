dotfiles
====

macOS環境の設定ファイル群

## Description
マルチ環境でも環境構築できるように，アプリの設定・手順を自動化する

## Content

* dot files
  * bash
  * vim
* installer
  * ansible + cask

## Install

+ git clone
+ cd dotfiles
+ create symbolic links
+ cd apps
+ sh install.sh

## Update

```
$ brew cask cleanup --outdated
$ brew cask install --force $(brew cask list)
```
