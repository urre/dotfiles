#!/bin/bash
set -euo pipefail

# Display message 'Setting up my Mac...'
echo "Setting up my Mac..."
sudo -v

# Setup .ssh/config
mkdir -p $(dirname "$HOME/.ssh")
ln -sfn ssh-config "$HOME/.ssh/config"

# Update Homebrew
brew update

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

if test ! $(which brew); then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install nvm
echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.1/install.sh | bash

# Install Homebrew Packages
cd ~
echo "Installing Homebrew packages"

homebrew_packages=(
	"circleci"
	"ffmpeg"
	"git-standup"
	"git"
	"gradle"
	"imagemagick"
	"jq"
	"mysql"
	"node"
	"openssl"
	"php"
	"pipenv"
	"python3"
	"starship"
	"yarn",
	"gh",
	"watch"
)

for homebrew_package in "${homebrew_packages[@]}"; do
	brew install "$homebrew_package"
done

# Install Homebrew cask packages
echo "Installing Homebrew cask packages"
brew tap homebrew/cask-fonts

homebrew_cask_packages=(
	"1Password"
	"adobe-creative-cloud"
	"alfred"
	"arq"
	"brave-browser"
	"calibre"
	"daisydisk"
	"docker"
	"dropbox"
	"firefox"
	"font-ibm-plex"
	"font-roboto-mono"
	"font-roboto"
	"font-jetbrains-mono"
	"fork"
	"google-chrome"
	"handbrake"
	"hyper"
	"insomnia"
	"kap"
	"magnet"
	"ngrok"
	"notion"
	"now"
	"numi"
	"rocket"
	"roon"
	"sequel-pro"
	"skype"
	"slack"
	"soulver"
	"spectacle"
	"spotify"
	"tidal"
	"transmit"
	"typora"
	"viscosity"
	"git-standup"
	"visual-studio-code"
	"vlc",
)

for homebrew_cask_package in "${homebrew_cask_packages[@]}"; do
	brew install "$homebrew_cask_package"
done

# Install Java
echo "Installing Java"
brew tap AdoptOpenJDK/openjdk
brew install openjdk@8
brew install openjdk@11
brew install openjdk@17

# Install Composer
echo "Installing Composer"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Installing global Node.js packages
echo "Installing Global Node.js packages"
npm i -g gatsby-cli netlify-cli vercel serve -g

# Generate SSH key
echo "Generating SSH keys"
ssh-keygen -t rsa

echo "Copied SSH key to clipboard - You can now add it to Github, Bitbucket etc"
pbcopy <~/.ssh/id_rsa.pub

# Register the global gitignore file
git config --global core.exludesfile ~/.dotfiles/.gitconfig_global

# Symlink VS Code settings and keybindings
ln -sf ~/.dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -sf ~/.dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Complete
echo "Installation Complete"
