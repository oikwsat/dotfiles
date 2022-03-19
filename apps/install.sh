#!/bin/sh
##
## initialize
##

# install homebrew
which brew > /dev/null && echo "homebrew is installed "|| /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install ansible
which ansible > /dev/null && echo "ansible is installed"  || brew install ansible

# setup by ansible
ansible-playbook --ask-become-pass -i hosts playbook.yml
