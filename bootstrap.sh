#!/usr/bin/env bash
#
# bootstrap.sh - dotfiles setup for a new (Apple Silicon) Mac
#
# Usage: bash bootstrap.sh
#
# What it does:
#   1. Ensure Xcode Command Line Tools
#   2. Install Homebrew (if missing)
#   3. Install stow + ansible via brew
#   4. Stow each package into $HOME
#   5. Run the ansible playbook for brew/cask/npm/pip/macOS defaults
#
# Idempotent: safe to re-run.

set -euo pipefail
cd "$(dirname "$0")"

PACKAGES=(zsh bash readline vim git ghostty claude gemini)

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }

# 1. Xcode Command Line Tools
if ! xcode-select -p >/dev/null 2>&1; then
  log "Installing Xcode Command Line Tools (will open a GUI prompt)"
  xcode-select --install || true
  echo "Re-run this script after the installer finishes."
  exit 0
fi

# 2. Homebrew (Apple Silicon: /opt/homebrew)
if ! command -v brew >/dev/null 2>&1; then
  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# 3. stow + ansible
brew list stow    >/dev/null 2>&1 || brew install stow
brew list ansible >/dev/null 2>&1 || brew install ansible

# 4. Stow dotfiles into $HOME
log "Stowing packages: ${PACKAGES[*]}"
stow -t "$HOME" "${PACKAGES[@]}"

# 5. Ansible playbook (Brew formulae, casks, npm, pip, macOS defaults)
log "Running ansible playbook"
ansible-playbook --ask-become-pass -i ansible/hosts ansible/playbook.yml

log "Done. Open a new shell to pick up the new environment."
