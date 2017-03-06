#!/bin/sh
##
## update Apps
##

brew update

brew cask cleanup --outdated

brew cask install --force $(brew cask list)
