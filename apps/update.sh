#!/bin/sh
##
## update Apps
##

brew update
brew cleanup

brew cask install --force $(brew cask list)
