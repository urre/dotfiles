alias cd..='cd ..'
alias cls="clear"
alias size="du -k -a | sort -n"
alias iip="ifconfig |grep inet"
alias eip="curl icanhazip.com"

# Git
alias gitlog="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
alias gb="git branch | grep '^\*' | cut -d' ' -f2 | pbcopy"

# Docker
alias dockerkill='docker kill $(docker ps -q)'
alias dockerdelete='docker rm $(docker ps -a -q)'
alias dockerdeleteimages='docker rmi $(docker images -q)'
alias dockerstop='docker stop $(docker ps -a -q)'

# Open in VS Code
function code {
    if [[ $# = 0 ]]
    then
        open -a "Visual Studio Code"
    else
        local argPath="$1"
        [[ $1 = /* ]] && argPath="$1" || argPath="$PWD/${1#./}"
        open -a "Visual Studio Code" "$argPath"
    fi
}

# Show whats running on port X
function port() {
  lsof -nP -iTCP:"$1"
}

# Merge two images side by side, open in Preview
function mont() {
  montage -background '#f2f2f2' -geometry 100% ~/desktop/"$1" ~/desktop/"$2" ~/desktop/merged.png;
  open -a Preview ~/desktop/merged.png
}
