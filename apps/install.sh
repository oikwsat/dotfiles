#!/bin/sh
##
## initialize
##

# install homebrew
which brew > /dev/null && echo "homebrew is installed "|| ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install ansible
which ansible > /dev/null && echo "ansible is installed"  || brew install ansible

# setup by ansible
ansible-playbook --ask-become-pass -i hosts playbook.yml
