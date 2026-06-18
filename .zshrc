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

# Atlassian API token for Curity Bitbucket/Atlassian MCP — stored in macOS Keychain.
# The stored value is base64("email:api_token"); the MCP base64-decodes it. Update with:
#   security add-generic-password -s atlassian-basic-auth -a "$USER" -U \
#     -w "$(printf %s 'urban.sanden@curity.io:NEW_TOKEN' | base64 | tr -d '\n')"
# NB: Bitbucket needs an API token created "with scopes" (Bitbucket read repo + write PR) — a plain Jira token 401s.
export ATLASSIAN_BASIC_AUTH="$(security find-generic-password -s atlassian-basic-auth -w 2>/dev/null)"
########### java ###########
export PATH="$HOME/.zuluhome/java/bin:$PATH"
