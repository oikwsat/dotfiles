#!/bin/sh
##
## update Apps
##

bash-it update

brew update
brew upgrade
brew cleanup

brew cask upgrade