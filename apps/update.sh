#!/bin/sh
##
## update Apps
##

brew cask cleanup --outdated

brew cask install --force $(brew cask list)
