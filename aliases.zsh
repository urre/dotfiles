alias cls="clear"
alias size="du -k -a | sort -n"
alias iip="ifconfig | grep inet"
alias eip="curl icanhazip.com"
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# Git language in English
alias git="LANG=en_US.UTF.8 git"

alias gl="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

# Git log today
alias glt="git log --no-merges --since="6am" --pretty=oneline --abbrev-commit"

# Git log this week
alias glw="git shortlog --all --no-merges --author $(git config user.email) --since "1 week ago""

# Git status
alias gs="git status -s"

# Copy current git branch name in clipboard
alias gb="git branch | grep '^\*' | cut -d' ' -f2 | pbcopy"

# Check total git commits across all branches
alias gt="git rev-list --all --count"

# Total git branches
alias gbt="git branch | wc -l"

# Number of commits per author on all branches
alias gct="git shortlog -s -n --all --no-merges --since='1 Jan, 2019'"

# Show files changes, insertions and deletions in one line
alias gshort="git diff --shortstat | sed '/^\s*$/d'"

# Docker
alias dockerkill='docker kill $(docker ps -q)'
alias dockerdelete='docker rm $(docker ps -a -q)'
alias dockerdeleteimages='docker rmi $(docker images -q)'
alias dockerstop='docker stop $(docker ps -a -q)'
alias dki='docker images'
alias du='docker-compose up -d'

# Standup work
alias supcurity='cd ~/projects/twobo && git standup -a "Urban" -s -m 3'
alias supcurityweekend='cd ~/projects/twobo && git standup -a "Urban" -d 3 -s -m 3'
alias supcurityall='cd ~/projects/twobo && git standup -a "all" -m 3'
alias supcurityweekendall='cd ~/projects/twobo && git standup -a "all" -d 3 -m 3'

# Standup personal
alias suppersonal='cd ~/projects && git standup -a "Urban" -s -m 3'
alias suppersonalweekend='cd ~/projects && git standup -a "Urban" -d 3 -s -m 3'
alias suppersonalall='cd ~/projects && git standup -a "all" -s -m 3'

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

function take() {
  mkdir $1 && cd $_
}


# Show whats running on port X
function port() {
  lsof -nP -iTCP:"$1"
}

# Merge two images side by side, then open in Preview
# Usage example: mont 1.jpg 2.jpg
function mont() {
  montage -background '#f2f2f2' -geometry 1280x720+0+0 ~/desktop/"$1" ~/desktop/"$2" ~/desktop/merged.jpg;
  open -a Preview ~/desktop/merged.jpg
}


# Annotate two images with "Before" and "After". Then merge two images side by side. Upload to Cloudinary if upload flag passed
# Usage example: amont 1.jpg 2.jpg upload
function amont() {

  # I store my screenshots on the desktop, so start here
  cd ~/desktop

  # Add the Before/After text
  convert "$1" -undercolor white -pointsize 66 -fill red  -gravity Northwest -annotate 0 'Before' "$1"
  convert "$2" -undercolor white -pointsize 66 -fill "#78BE21"  -gravity Northwest -annotate 0 'After' "$2"

  # Merge the two images side by side, open the image in Preview
  # montage -background '#f2f2f2' -geometry 1280x720+0+0 1.jpg 2.jpg merged.jpg;
  convert -background "#6e768f" 2.jpg +append \( 1.jpg \) -append -resize 1600x1600 result.jpg

  # Open in Preview
  open -a Preview ~/desktop/result.jpg

  # Upload to CDN if upload flag passed
  if [ "$3" = 'upload' ]
  then
    DIR=$( cd ~/.dotfiles && pwd )
    source "$DIR/.env"
    CLOUDINARY_URL=$(echo "$CLOUDINARY_URL")
    export CLOUDINARY_URL
    # Upload to Cloudinary and then copy the HTTPS image link to clipboard (using the cld uploader)
    cld uploader upload ~/desktop/merged.jpg | jq -r '.secure_url' | pbcopy
  fi


}

# Java
# The openjdk@8 is also a keg-only; we need to create a symbolic link so that the macOS java wrapper can find it.
# sudo ln -sfn /usr/local/opt/openjdk@8/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-8.jdk
# https://docs.brew.sh/FAQ#what-does-keg-only-mean

sudo ln -sfn /usr/local/opt/openjdk@11/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-11.jdk

# Switch Java versions
function java8() {
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home
  export PATH="$JAVA_HOME/bin:$PATH"
}

function java11() {
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-11.jdk/Contents/Home
  export PATH="$JAVA_HOME/bin:$PATH"
}
