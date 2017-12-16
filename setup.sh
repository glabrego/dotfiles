#! /bin/bash
echo '👨🏻‍💻  Setting everythin up 🤓'

echo 'Adding git keys to ssh-agent 🕵'
ssh-add -K ~/.ssh/id_rsa
echo 'done'

echo 'Installing Homebrew 🍻'
if command -v brew >/dev/null 2>&1; then
  echo 'Homebrew already installed 🙄'
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
git config --global core.editor vim
echo 'Done!'

echo 'Cloning most needed repos 🗄'
git clone git@github.com:glabrego/dotfiles.git ~/workspace/dotfiles &
git clone git@github.com:glabrego/my-changelog.git ~/workspace/my-changelog &
git clone git@github.com:glabrego/glabrego.github.io.git ~/workspace/glabrego.github.io &
git clone git@github.com:glabrego/glabrego-codes.git ~/workspace/glabrego-codes &
wait
echo 'Done!'

echo 'Bundling Homebrew ☕️'
cd ~/workspace/dotfiles && brew bundle
echo 'Done!'

echo 'Setting ZSH as default shell 😎'
sudo sh -c "echo '/usr/local/bin/zsh' >> /etc/shells"
chsh -s /usr/local/bin/zsh
echo 'Done!'

echo 'Installing oh-my-zsh 🤯'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo 'Done!'

echo 'Symlinking dotfiles 🔗'
ln -s ~/workspace/dotfiles/.aliases   ~/.aliases
ln -s ~/workspace/dotfiles/.functions ~/.functions
ln -s ~/workspace/dotfiles/.zshrc     ~/.zshrc
ln -s ~/workspace/dotfiles/.vimrc     ~/.vimrc
ln -s ~/workspace/dotfiles/.vimrc     ~/.tmux.conf
ln -s ~/workspace/dotfiles/.spacemacs ~/.spacemacs
echo 'Done!'

echo 'Configuring Neovim ⌨️ '
mkdir -p ~/.config/nvim/
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c :PlugInstall --headless &
echo 'Done!'
