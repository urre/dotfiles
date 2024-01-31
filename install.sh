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
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.1/install.sh | bash

# Install Node.js using nvm
nvm install 14.17.5
nvm install 16.14.2
nvm install 18.3.0

# Install Homebrew Packages
cd ~
echo "Installing Homebrew packages"

# Install Homebrew packages
echo "Installing Homebrew cask packages"
brew tap homebrew/cask-fonts

homebrew_packages=(
	"1Password"
	"adobe-creative-cloud"
	"alfred"
	"brave-browser"
	"calibre"
	"daisydisk"
	"docker"
	"dropbox"
	"ffmpeg"
	"fig"
	"firefox"
	"font-ibm-plex"
	"font-jetbrains-mono"
	"font-roboto-mono"
	"font-roboto"
	"fork"
	"gh",
	"git-standup"
	"git"
	"google-chrome"
	"gradle"
	"handbrake"
	"hyper"
	"imagemagick"
	"insomnia"
	"jq"
	"kap"
	"magnet"
	"mkcert",
	"mysql"
	"ngrok"
	"node"
	"notion"
	"now"
	"nss"
	"numi"
	"openssl"
	"php"
	"pipenv"
	"python3"
	"rectangle"
	"rocket"
	"roon"
	"sequel-pro"
	"slack"
	"spotify"
	"starship"
	"tidal"
	"transmit"
	"typora"
	"viscosity"
	"visual-studio-code"
	"vlc",
	"watch"
	"yarn",
)

for homebrew_package in "${homebrew_packages[@]}"; do
	brew install "$homebrew_package"
done

# Raycast
brew install --cask raycast

# VLC
brew install --cask vlc

# Google Drive
brew install --cask google-drive

# Zoom
brew install --cask zoom

# Messenger
brew install --cask messenger

# ChronoSync Express
brew install --cask chronosync

# NetNewsWire
brew install --cask netnewswire

# Edge
brew install --cask microsoft-edge

# Install Poetry
curl -sSL https://install.python-poetry.org | python3 -

# Cloudinary CLI
pip3 install cloudinary-cli

# Install Java
echo "Installing Java"
brew tap AdoptOpenJDK/openjdk
brew install openjdk@8
brew install openjdk@11
brew install openjdk@17
brew install openjdk@21

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
npm i -g fast-cli

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
