#!/bin/sh
##
## update Apps
##

$BASH_IT/bash_it.sh update stable

brew update
brew upgrade
brew cleanup

brew upgrade --cask
