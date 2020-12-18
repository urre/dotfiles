# Path to dotfiles
export DOTFILES=$HOME/.dotfiles

ZSH_CUSTOM=$DOTFILES

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="half-life"
#ZSH_THEME="spaceship"

# Plugins
plugins=(git zsh-z)
source $ZSH/oh-my-zsh.sh

# Nano as crontab editor
export EDITOR=nano

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init zsh)"
