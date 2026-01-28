#! /bin/bash
echo '👨🏻‍💻  Setting everythin up 🤓'

echo 'Adding git keys to ssh-agent 🕵'
ssh-add -K ~/.ssh/id_rsa
echo 'done'

echo 'Installing Homebrew 🍻'
if command -v brew >/dev/null 2>&1; then
  echo 'Homebrew already installed 🙄'
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'Homebrew installed!'
fi

echo 'Creating workspace dir 📁'
mkdir ~/workspace
echo '~/workspace created!'

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
git clone git@github.com:glabrego/dotfiles.git ~/workspace/dotfiles &
git clone git@github.com:glabrego/my-changelog.git ~/workspace/my-changelog &
git clone git@github.com:glabrego/glabrego.github.io.git ~/workspace/glabrego.github.io &
git clone git@github.com:glabrego/glabrego-codes.git ~/workspace/glabrego-codes &
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm &
wait
echo 'Done!'

echo 'Bundling Homebrew ☕️'
cd ~/workspace/dotfiles && brew bundle
echo 'Done!'

echo 'Setting ZSH as default shell 😎'
ZSH_PATH="$(brew --prefix)/bin/zsh"
if ! grep -q "$ZSH_PATH" /etc/shells; then
  sudo sh -c "echo '$ZSH_PATH' >> /etc/shells"
fi
chsh -s "$ZSH_PATH"
echo 'Done!'

echo 'Symlinking dotfiles 🔗'
ln -s ~/workspace/dotfiles/.aliases   ~/.aliases
ln -s ~/workspace/dotfiles/.functions ~/.functions
ln -s ~/workspace/dotfiles/.zshrc     ~/.zshrc
ln -s ~/workspace/dotfiles/.tmux.conf ~/.tmux.conf
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

