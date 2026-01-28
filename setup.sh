#! /bin/bash
set -e  # Exit on error for critical commands

echo '👨🏻‍💻  Setting everythin up 🤓'

echo 'Checking Command Line Tools 🛠️'
if ! xcode-select -p &>/dev/null; then
  echo 'Command Line Tools not found. Installing...'
  xcode-select --install
  echo ''
  echo '⚠️  Please complete the Command Line Tools installation dialog.'
  echo '⚠️  After installation completes, re-run this script: ./setup.sh'
  exit 0
else
  echo 'Command Line Tools already installed ✓'
fi

echo 'Adding git keys to ssh-agent 🕵'
if [ -f ~/.ssh/id_rsa ]; then
  ssh-add -K ~/.ssh/id_rsa || echo '⚠️  Warning: Could not add SSH key to agent'
  echo 'SSH key added!'
else
  echo 'No SSH key found at ~/.ssh/id_rsa, skipping...'
fi

echo 'Installing Homebrew 🍻'
if command -v brew >/dev/null 2>&1; then
  echo 'Homebrew already installed 🙄'
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'Homebrew installed!'
fi

echo 'Creating workspace dir 📁'
mkdir -p ~/workspace
echo '~/workspace ready!'

echo 'Installing Git 🎒'
if command -v git >/dev/null 2>&1; then
  echo 'Git already installed 🙄'
else
  brew install git
  echo 'Git installed!'
fi

echo 'Setting up git configuration 📲'
git config --global user.name 'Guilherme Labrego'
git config --global user.email 'glabrego@gmail.com'
git config --global core.editor nvim
echo 'Done!'

echo 'Cloning most needed repos 🗄'
[ ! -d ~/workspace/dotfiles ] && gh repo clone glabrego/dotfiles ~/workspace/dotfiles || true &
[ ! -d ~/workspace/my-changelog ] && gh repo clone glabrego/my-changelog ~/workspace/my-changelog || true &
[ ! -d ~/workspace/glabrego.github.io ] && gh repo clone glabrego/glabrego.github.io ~/workspace/glabrego.github.io || true &
[ ! -d ~/workspace/glabrego-codes ] && gh repo clone glabrego/glabrego-codes ~/workspace/glabrego-codes || true &
[ ! -d ~/.tmux/plugins/tpm ] && gh repo clone tmux-plugins/tpm ~/.tmux/plugins/tpm || true &
wait
echo 'Done!'

echo 'Bundling Homebrew ☕️'
cd ~/workspace/dotfiles && brew bundle
echo 'Done!'

echo 'Setting up GitHub CLI 🔑'
if command -v gh &>/dev/null; then
  if ! gh auth status &>/dev/null; then
    echo '⚠️  GitHub CLI not authenticated. Attempting login...'
    gh auth login
  else
    echo 'GitHub CLI already authenticated ✓'
  fi
else
  echo '⚠️  GitHub CLI (gh) not found. Install it with: brew install gh'
  exit 1
fi

echo 'Setting ZSH as default shell 😎'
ZSH_PATH="$(brew --prefix)/bin/zsh"
if ! grep -q "$ZSH_PATH" /etc/shells; then
  sudo sh -c "echo '$ZSH_PATH' >> /etc/shells"
fi
chsh -s "$ZSH_PATH"
echo 'Done!'

echo 'Symlinking dotfiles 🔗'
ln -sf ~/workspace/dotfiles/.aliases   ~/.aliases
ln -sf ~/workspace/dotfiles/.functions ~/.functions
ln -sf ~/workspace/dotfiles/.zshrc     ~/.zshrc
ln -sf ~/workspace/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/workspace/dotfiles/starship.toml ~/.config/starship.toml
echo 'Done!'

echo 'Installing Tmux plugins 🔌'
~/.tmux/plugins/tpm/bin/install_plugins
echo 'Done!'

echo 'Configuring Neovim ⌨️ '
mkdir -p ~/.config/
ln -sf ~/workspace/dotfiles/nvim ~/.config/nvim
echo 'Installing Neovim plugins...'
nvim --headless "+Lazy! sync" +qa
echo 'Done!'

echo 'Configuring Ghostty terminal 👻'
ln -sf ~/workspace/dotfiles/ghostty ~/.config/ghostty
echo 'Done!'

echo 'Configuring Atuin shell history 📜'
ln -sf ~/workspace/dotfiles/atuin ~/.config/atuin
echo 'Done!'

echo 'Configuring Karabiner keyboard customization ⌨️ '
ln -sf ~/workspace/dotfiles/karabiner ~/.config/karabiner
echo 'Done!'

echo 'Setting macOS defaults ⚙️ '
# Keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock minimize-to-application -bool true

# Screenshots
defaults write com.apple.screencapture location -string "${HOME}/Desktop"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

# Trackpad
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Restart affected apps
killall Finder Dock SystemUIServer &>/dev/null || true
echo 'Done!'

echo ''
echo '🔍 Verifying installation...'
echo ''

# Check critical tools
VERIFICATION_FAILED=0

check_command() {
  if command -v "$1" &>/dev/null; then
    echo "✅ $2"
  else
    echo "❌ $2 - NOT FOUND"
    VERIFICATION_FAILED=1
  fi
}

check_file() {
  if [ -e "$1" ]; then
    echo "✅ $2"
  else
    echo "❌ $2 - NOT FOUND"
    VERIFICATION_FAILED=1
  fi
}

# Core tools
check_command "brew" "Homebrew"
check_command "git" "Git"
check_command "zsh" "Zsh"
check_command "nvim" "Neovim"
check_command "tmux" "Tmux"
check_command "starship" "Starship"
check_command "atuin" "Atuin"

# Symlinks
check_file ~/.zshrc "Zsh config"
check_file ~/.tmux.conf "Tmux config"
check_file ~/.aliases "Shell aliases"
check_file ~/.functions "Shell functions"
check_file ~/.config/nvim "Neovim config"
check_file ~/.config/starship.toml "Starship config"
check_file ~/.config/ghostty "Ghostty config"
check_file ~/.config/atuin "Atuin config"
check_file ~/.config/karabiner "Karabiner config"
check_file ~/.tmux/plugins/tpm "Tmux Plugin Manager"

echo ''
if [ $VERIFICATION_FAILED -eq 0 ]; then
  echo '🎉 Setup completed successfully!'
  echo ''
  echo 'Next steps:'
  echo '  1. Restart your terminal or run: source ~/.zshrc'
  echo '  2. Open Neovim to verify plugins loaded correctly'
  echo '  3. Open Tmux to verify theme and plugins'
else
  echo '⚠️  Setup completed with some issues. Please review the items marked with ❌'
  exit 1
fi

