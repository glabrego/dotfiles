#!/bin/bash
set -e  # Exit on error

# ============================================================================
# Help and Usage
# ============================================================================

show_help() {
  cat << EOF
Dotfiles Update Script

DESCRIPTION:
  Updates all components of your dotfiles environment including dotfiles from git,
  Homebrew packages, Tmux plugins, Neovim plugins, and Atuin shell history.

USAGE:
  ./update.sh [OPTIONS]

OPTIONS:
  -h, --help    Show this help message and exit

WHAT IT DOES:
  1. Pulls latest dotfiles from git repository
  2. Updates Homebrew package manager
  3. Upgrades all Homebrew packages
  4. Cleans up Homebrew cache
  5. Updates Tmux plugins via TPM
  6. Updates Neovim plugins via Lazy.nvim
  7. Syncs Atuin shell history

EXAMPLES:
  ./update.sh          Run all updates
  ./update.sh --help   Show this help message

NOTE:
  You may need to restart your terminal after updates complete for
  some changes to take effect.

For more information, visit: https://github.com/glabrego/dotfiles
EOF
  exit 0
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      show_help
      ;;
    *)
      echo "Unknown option: $1"
      echo "Use --help for usage information"
      exit 1
      ;;
  esac
  # shellcheck disable=SC2317
  shift
done

# ============================================================================
# Update Operations
# ============================================================================

echo '🔄 Updating dotfiles and tools...'
echo ''

# Update dotfiles from git
echo '📥 Pulling latest dotfiles...'
cd ~/workspace/dotfiles
git pull origin master
echo '✅ Dotfiles updated!'
echo ''

# Update Homebrew and packages
echo '🍺 Updating Homebrew...'
brew update
echo '✅ Homebrew updated!'
echo ''

echo '📦 Upgrading Homebrew packages...'
brew upgrade
echo '✅ Packages upgraded!'
echo ''

echo '🧹 Cleaning up Homebrew...'
brew cleanup
echo '✅ Homebrew cleaned!'
echo ''

# Update Tmux plugins
echo '🔌 Updating Tmux plugins...'
if [ -d ~/.tmux/plugins/tpm ]; then
  ~/.tmux/plugins/tpm/bin/update_plugins all
  echo '✅ Tmux plugins updated!'
else
  echo '⚠️  TPM not found, skipping Tmux plugin updates'
fi
echo ''

# Update Neovim plugins
echo '⌨️  Updating Neovim plugins...'
if command -v nvim &>/dev/null; then
  nvim --headless "+Lazy! sync" +qa
  echo '✅ Neovim plugins updated!'
else
  echo '⚠️  Neovim not found, skipping plugin updates'
fi
echo ''

# Update Atuin
echo '📜 Syncing Atuin history...'
if command -v atuin &>/dev/null; then
  atuin sync || echo '⚠️  Atuin sync failed (might not be configured)'
  echo '✅ Atuin sync attempted!'
else
  echo '⚠️  Atuin not found, skipping'
fi
echo ''

echo '🎉 Update completed!'
echo ''
echo 'Summary:'
echo '  ✅ Dotfiles pulled from git'
echo '  ✅ Homebrew and packages updated'
echo '  ✅ Tmux plugins updated'
echo '  ✅ Neovim plugins updated'
echo '  ✅ Atuin history synced'
echo ''
echo 'You may need to restart your terminal for some changes to take effect.'
