#!/bin/bash
set -euo pipefail

# Display message 'Setting up my Mac...'
echo "Setting up my Mac..."
sudo -v

# Setup .ssh/config
mkdir -p $(dirname "$HOME/.ssh")
ln -sfn ssh-config "$HOME/.ssh/config"

# Install and use zsh from Homebrew
echo "Installing zsh from Homebrew..."
brew install zsh
chsh -s /usr/local/bin/zsh

# Oh My Zsh
echo "Installing Oh My Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Z for Oh My Zsh
echo "Installing Z"
git clone git@github.com:agkozak/zsh-z.git $ZSH_CUSTOM/plugins/zsh-z

# Configure symlinks
ln -s ~/.dotfiles/.zshrc ~/.zshrc

# Source .zhrc file
echo "Sourcing ~/.zhrc"
source ~/.zhrc

# Install Homebrew
echo "Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install nvm
echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.40.5/install.sh | bash

# Install Node.js using nvm
nvm install 24.14.0

# Install Homebrew packages (formulae + casks) from the Brewfile
cd ~
echo "Installing Homebrew packages from Brewfile"
brew bundle --file="$HOME/.dotfiles/Brewfile"

# Install Poetry
curl -sSL https://install.python-poetry.org | python3 -

# Cloudinary CLI
pip3 install cloudinary-cli

# Install Composer
echo "Installing Composer"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Installing global Node.js packages
echo "Installing Global Node.js packages"
npm i -g gatsby-cli
npm i -g netlify-cli
npm i -g vercel
npm i -g serve
npm i -g http-server
npm i -g svgo
npm i -g contentful

# Generate SSH key
echo "Generating SSH keys"
ssh-keygen -t rsa

echo "Copied SSH key to clipboard - You can now add it to GitHub, Bitbucket etc"
pbcopy <~/.ssh/id_rsa.pub

# Register the global gitignore file
git config --global core.exludesfile ~/.dotfiles/.gitconfig_global

# Symlink VS Code settings and keybindings
ln -sf ~/.dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -sf ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Complete
echo "Installation Complete"
