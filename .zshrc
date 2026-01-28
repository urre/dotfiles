# Path to dotfiles
export DOTFILES=$HOME/.dotfiles

ZSH_CUSTOM=$DOTFILES

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Curity Identity Server paths
export IDSVR_HOME=/Users/urbansanden/projects/twobo/idsvr/dist
export PATH=$PATH:$IDSVR_HOME/bin/

# Plugins
plugins=(git zsh-z gitfast zsh-nvm zsh-nvm-auto-switch)

# Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Load aliases
source ~/.dotfiles/aliases.zsh
source ~/.dotfiles/aliases-work.zsh

# Image tools
source ~/.dotfiles/image-tools.zsh

# Vide tools
source ~/.dotfiles/video-tools.zsh

# Starship prompt
export STARSHIP_CONFIG="$DOTFILES/starship.toml"
eval "$(starship init zsh)"

# Nano as crontab editor
export EDITOR=nano

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Use Node v22.19.0 by default
nvm use 22.19.0 --silent

########### pyenv ###########
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PATH=$HOME/.pyenv/shims/:$PATH
export PATH="$HOME/.local/bin:$PATH"
