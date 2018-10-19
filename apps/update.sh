#!/bin/sh
##
## update Apps
##

brew update
brew upgrade
brew cleanup

brew cask install --force $(brew cask list)
