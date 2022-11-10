# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Path to dotfiles
export DOTFILES=$HOME/.dotfiles

ZSH_CUSTOM=$DOTFILES

# Path to Curity Identiy Server CLI binary (idsvr)
export PATH=$PATH:/Users/urbansanden/projects/twobo/identity-server/dist/bin/

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Path to Java
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home

# Plugins
plugins=(git zsh-z gitfast zsh-nvm zsh-nvm-auto-switch)

source $ZSH/oh-my-zsh.sh

# Nano as crontab editor
export EDITOR=nano

# pure prompt
fpath+=($HOME/.zsh/pure)

autoload -U promptinit; promptinit
prompt pure

export PATH="$HOME/.poetry/bin:$PATH"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
