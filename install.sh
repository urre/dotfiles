#!/bin/bash
set -euo pipefail

# Display message 'Setting up my Mac...'
echo "Setting up my Mac..."
sudo -v

# Setup .ssh/config
mkdir -p $(dirname "$HOME/.ssh")
ln -sfn ssh-config "$HOME/.ssh/config"

# Update homebrew recipes
brew update

# Install zsh from Homebrew
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

# Homebrew - Installation
echo "Installing Homebrew"

if test ! $(which brew); then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install NVM
echo "Installing nvm"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.1/install.sh | bash

# Install Homebrew Packages
cd ~
echo "Installing Homebrew packages"

homebrew_packages=(
	"git"
	"git-standup"
	"mysql"
	"php"
	"node"
	"yarn"
	"imagemagick"
	"openssl"
	"python3"
	"svtplay-dl"
	"youtube-dl"
	"gradle"
	"ffmpeg"
	"jq"
)

for homebrew_package in "${homebrew_packages[@]}"; do
	brew install "$homebrew_package"
done

# Install Casks
echo "Installing Homebrew cask packages"
brew tap homebrew/cask-fonts

homebrew_cask_packages=(
	"1Password"
	"alfred"
	"docker"
	"firefox"
	"google-chrome"
	"insomnia"
	"slack"
	"tidal"
	"spotify"
	"telegram"
	"typora"
	"vlc"
	"calibre"
	"visual-studio-code"
	"viscosity"
	"transmit"
	"soulver"
	"skype"
	"sequel-pro"
	"roon"
	"now"
	"notion"
	"hyper"
	"fork"
	"handbrake"
	"dropbox"
	"brave-browser"
	"arq"
	"app-cleaner"
	"spectacle"
	"daisydisk"
	"font-inconsolata"
	"adobe-creative-cloud"
)

for homebrew_cask_package in "${homebrew_cask_packages[@]}"; do
	brew cask install "$homebrew_cask_package"
done

# Install java8
echo "Installing java8"
brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk8
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

# Install Composer
echo "Installing Composer"
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Installing Global Node Dependecies
echo "Installing Global Node Dependecies"
npm i -g netlify-cli
npm i -g now

# Generate SSH key
echo "Generating SSH keys"
ssh-keygen -t rsa

echo "Copied SSH key to clipboard - You can now add it to Github"
pbcopy <~/.ssh/id_rsa.pub

# Register the Global Gitignore file
git config --global core.exludesfile ~/.dotfiles/.gitconfig_global

# Complete
echo "Installation Complete"
