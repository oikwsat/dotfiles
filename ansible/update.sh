#!/bin/sh
##
## update Apps
##

brew update
brew upgrade
brew cleanup

brew upgrade --cask
