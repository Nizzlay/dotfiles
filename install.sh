#!/usr/bin/env bash

# Stop execution instantly when a query exits while having a non-zero status
set -e

# Set variable to current path
CURRENT_PATH=$(pwd)

# xcode-select --install
xcode-select --install

# Check for homebrew
if [[ $(command -v brew) != 0 ]]; then
    echo 'Installing Homebrew...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Add sources for brew
brew tap \
    homebrew/core \
    homebrew/cask \
    homebrew/cask-fonts \
    homebrew/services \
    espanso/espanso \
    romkatv/powerlevel10k

# Reload updated brew
brew update
brew cask update
brew upgrade

# Install brew packages
sh ./brew_packages.sh

# Install brew casks
sh ./brew_casks.sh

# Install brew fonts
sh ./brew_fonts.sh

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