#!/usr/bin/env bash

# Stop execution instantly when a query exits while having a non-zero status
set -e

# Set variable to current path
CURRENT_PATH=$(pwd)

if [[ $(uname -m) == 'arm64' ]]; then
    echo "Setting Path to /opt/homebrew/bin:\$PATH"
    export PATH=/opt/homebrew/bin:$PATH
else
    echo "Setting Path to /usr/local/bin:\$PATH"
    export PATH=/usr/local/bin:$PATH
fi

# Install homebrew
if [[ $(command -v brew) != 0 ]]; then
    echo 'Installing Homebrew...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/nizzlay/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo 'Installing Brew Packages...'
brew update
brew tap homebrew/bundle
brew bundle

# Set shell
grep -Fxq '$(brew --prefix)/bin/zsh' /etc/shells || sudo bash -c "echo $(brew --prefix)/bin/zsh >> /etc/shells"
chsh -s $(brew --prefix)/bin/zsh "$USER"

# Install Mac App Store
sh ./mas.sh

# Dock config
sh ./dock_config.sh

# System preferences
sh ./macos.sh

# Terminal stuff
echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>~/.zshrc

# dotfiles config (symlink)
ln -sf "$CURRENT_PATH/files/.gitconfig" ~
ln -sf "$CURRENT_PATH/files/.gitignore" ~/.gitignore_global
ln -sf "$CURRENT_PATH/files/.zshrc" ~
ln -sf "$CURRENT_PATH/files/.p10k.zsh" ~
ln -sf "$CURRENT_PATH/files/.aliases" ~
ln -sf "$CURRENT_PATH/files/ssh_config" ~/.ssh/config
ln -sf "$CURRENT_PATH/files/flameshot.ini" ~/.config/flameshot/

echo 'Completed succesfully! 🥳'
exit 0;