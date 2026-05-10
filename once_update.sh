#!/usr/bin/env bash
#
# once_update.sh - one-time migration from old _<name> layout to GNU Stow layout.
#
# Run on each existing Mac AFTER `git pull` brings in the restructured tree.
# Not needed on a freshly bootstrapped Mac.
#
# What it does:
#   1. Backup current home dotfiles to ~/dotfiles-backup-YYYYMMDD-HHMMSS/
#   2. Unlink old symlinks (e.g. ~/.zshrc -> dotfiles/_zshrc) that are now dangling
#   3. Remove garbage (~/_bashrc, ~/.aerospace.toml, ~/.gitignore_global)
#   4. Move newly-tracked real files (~/.zprofile, ~/.gitconfig, etc.) into the
#      backup so stow can recreate them as symlinks
#   5. Run `stow -n` for a dry-run, then `stow` for real
#
# Idempotent: rerunning after success is a no-op.

set -euo pipefail
cd "$(dirname "$0")"

PACKAGES=(zsh bash readline vim git ghostty claude gemini)

TS="$(date +%Y%m%d-%H%M%S)"
BACKUP="$HOME/dotfiles-backup-$TS"
mkdir -p "$BACKUP"

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }

# 1. Old symlinks pointing into the previous layout (or now dangling)
OLD_LINKS=(
  ".zshrc" ".zshenv"
  ".bashrc" ".bash_profile" ".bash_aliases"
  ".vimrc" ".gvimrc"
  ".gemini/GEMINI.md"
)

log "Backup directory: $BACKUP"

for f in "${OLD_LINKS[@]}"; do
  if [ -L "$HOME/$f" ]; then
    mkdir -p "$BACKUP/$(dirname "$f")"
    cp -P "$HOME/$f" "$BACKUP/$f" 2>/dev/null || true
    unlink "$HOME/$f"
    log "Unlinked $HOME/$f"
  fi
done

# 2. Garbage symlinks / unused real files
if [ -L "$HOME/_bashrc" ]; then
  rm "$HOME/_bashrc"
  log "Removed stray ~/_bashrc symlink"
fi
if [ -L "$HOME/.aerospace.toml" ]; then
  rm "$HOME/.aerospace.toml"
  log "Removed dangling ~/.aerospace.toml symlink"
fi
if [ -f "$HOME/.gitignore_global" ] && [ ! -L "$HOME/.gitignore_global" ]; then
  mv "$HOME/.gitignore_global" "$BACKUP/.gitignore_global"
  log "Archived ~/.gitignore_global (replaced by ~/.config/git/ignore)"
fi

# 3. Real files now tracked in repo - move them aside so stow can take over
REAL_FILES=(
  ".zprofile"
  ".gitconfig"
  ".config/git/ignore"
  ".config/ghostty/config"
  ".claude/settings.json"
  ".gemini/settings.json"
)
for f in "${REAL_FILES[@]}"; do
  if [ -f "$HOME/$f" ] && [ ! -L "$HOME/$f" ]; then
    mkdir -p "$BACKUP/$(dirname "$f")"
    mv "$HOME/$f" "$BACKUP/$f"
    log "Archived $HOME/$f"
  fi
done

# 4. Dry-run first to surface any remaining conflict
log "Dry-run: stow -n -v ${PACKAGES[*]}"
stow -n -v -t "$HOME" "${PACKAGES[@]}"

# 5. Real stow
log "Stowing: ${PACKAGES[*]}"
stow -t "$HOME" "${PACKAGES[@]}"

log "Migration done. Backup: $BACKUP"
echo
echo "Verify:"
echo "  readlink ~/.zshrc"
echo "  readlink ~/.zprofile"
echo "  readlink ~/.gitconfig"
echo "  readlink ~/.config/ghostty/config"
echo "  git config --get user.email"
echo
echo "If everything works, the backup directory can be deleted."
