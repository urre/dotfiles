# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Path to dotfiles
export DOTFILES=$HOME/.dotfiles

ZSH_CUSTOM=$DOTFILES

# Path to Curity Identiy Server CLI binary (idsvr)
export PATH=$PATH:/Users/urbansanden/projects/twobo/identity-server/dist/bin/

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Path to Java 8
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

# Plugins
plugins=(git zsh-z gitfast)

source $ZSH/oh-my-zsh.sh

# Nano as crontab editor
export EDITOR=nano

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# compinit is the completion system from Z shell
autoload -Uz compinit && compinit
# Git completion
autoload -Uz vcs_info

precmd() { vcs_info }
setopt PROMPT_SUBST
zstyle ':vcs_info:git:*' formats '%F{153}%b'

# Prompt green/red
PROMPT='%(?.%F{green}●.%F{red}●%f) %F{211}%1~%f ${vcs_info_msg_0_} '
RPROMPT='%F{245}%*%f'

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
