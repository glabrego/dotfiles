#!/bin/bash
set -e  # Exit on error

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
