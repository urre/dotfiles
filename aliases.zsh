# Load some .env secreets
DIR=$( cd ~/.dotfiles && pwd )
source "$DIR/.env"

# General
alias cls="clear"
alias size="du -k -a | sort -n"
alias iip="ipconfig getifaddr en0"
alias eip="curl icanhazip.com"
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias prev="cd -"

# Work
alias gw="./gradlew"
alias dr="./debug/run"
alias bdw="npm run build.dev.watch"
alias rebuild="git submodule update && ./gradlew stopAll && ./gradlew clean packageDebug --parallel && ln -s ${HOME}/projects/twobo/curity-web-ui/dist/dev ${HOME}/projects/twobo/idsvr/dist/etc/admin-webui"
alias rebuildrf="git submodule update && ./gradlew stopAll && rm -rf ${HOME}/projects/twobo/idsvr/dist && ./gradlew packageDebug --parallel && ln -s ${HOME}/projects/twobo/curity-web-ui/dist/dev ${HOME}/projects/twobo/idsvr/dist/etc/admin-webui"
alias resym="ln -s ${HOME}/projects/twobo/curity-web-ui/dist/dev ${HOME}/projects/twobo/idsvr/dist/etc/admin-webui"
alias resymprod="ln -s ${HOME}/projects/twobo/curity-web-ui/dist/prod ${HOME}/projects/twobo/idsvr/dist/etc/admin-webui"
alias webmobile="iip | pbcopy"

# Git log
alias gl="git log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

# Git log today
alias glt="git log --no-merges --since="6am" --pretty=oneline --abbrev-commit"

# Git log this week
alias glw="git shortlog --all --no-merges --author $(git config user.email) --since "1 week ago""

# Git status
alias gs="git status -s"

# Copy current git branch name to clipboard
alias gb="git branch | grep '^\*' | cut -d' ' -f2 | pbcopy"

# Check total git commits across all branches
alias gt="git rev-list --all --count"

# Total git branches
alias gbt="git branch | wc -l"

# Number of commits per author on all branches
alias gct="git shortlog -s -n --all --no-merges --since='1 Jan, 2019'"

# Show files changes, insertions and deletions in one line
alias gshort="git diff --shortstat | sed '/^\s*$/d'"

# Show size of the current changed files in git status
alias gst="git_status_size"

git_status_size(){
  git status --porcelain | awk '{print $2}' | xargs ls -hl | sort -r -h | awk '{print $5 "\t" $9}'
}

# Git language in English
alias git="LANG=en_US.UTF.8 git"

# Docker
alias dockerkill='docker kill $(docker ps -q)'
alias dockerdelete='docker rm $(docker ps -a -q)'
alias dockerdeleteimages='docker rmi $(docker images -q)'
alias dockerstop='docker stop $(docker ps -a -q)'
alias dki='docker images'
alias dup='docker compose up'
alias dus='docker compose stop'
alias dud='docker compose down'

# Launch standup on Zoom
function sdev() {
  clear
  echo "Launching Zoom..."
  open "zoommtg://zoom.us/join?action=join&confno=${ZOOM_DEV_STANDUP_CONF_NO}&pwd=${ZOOM_STANDUP_PASSWORD}"
}

# Launch standup on Zoom
function spme() {
  clear
  echo "Launching Zoom..."
  open "zoommtg://zoom.us/join?action=join&confno=${ZOOM_PME_STANDUP_CONF_NO}&pwd=${ZOOM_STANDUP_PASSWORD}"
}

# Git Standup
alias log='cd ~/projects/twobo && git standup -a "Urban" -s -m 5'
alias logw='cd ~/projects/twobo && git standup -a "Urban" -d 3 -s -m 5'

# Git Standup personal
alias logp='cd ~/projects && git standup -a "Urban" -s -m 3'

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

# Create a directory an cd into the new directory at once
function take() {
  mkdir $1 && cd $_
}

# Show whats running on port X
function port() {
  lsof -nP -iTCP:"$1"
}

# Kill processes at a given port
function killport() {
    echo '🚨 Killing all processes at port' $1
    lsof -ti tcp:$1 | xargs kill
}

# Java
# The openjdk@X is keg-only; we need to create a symbolic link so that the macOS java wrapper can find it.
# https://docs.brew.sh/FAQ#what-does-keg-only-mean

# version 17
#brew install openjdk@17
#sudo ln -sfn /opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk-17.jdk

# Switch Java versions
function java17() {
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home
  export PATH="$JAVA_HOME/bin:$PATH"
}

# Merge two images side by side
# then open in Preview (for fast annotations etc)
# Usage example: mont 1.jpg 2.jpg
function mergex() {
  convert +append "$1" "$2" merged.jpg;
  # open -a Preview merged.jpg
  open -a CleanShot\ X/ merged.jpg
}

# Merge two images on top of eachother
# then open in Preview or CleanShotX (for fast annotations etc)
# Usage example: mont 1.jpg 2.jpg
function mergey() {
  convert -append "$1" "$2" merged.jpg;
  # open -a Preview ~/desktop/merged.jpg
  open -a CleanShot\ X/ merged.jpg
}

# Collage of all images in the current folder
function montageall() {
  montage -background '#f2f2f2' -geometry 1280x -tile 4x4 -border 80 -bordercolor white *.jpg merged.jpg
  open -a Preview merged.jpg
}

# Annotate two images with "Before" and "After". Then merge two images side by side. Upload to Cloudinary if upload flag passed
# Usage example: amont 1.jpg 2.jpg upload
function amont() {

  # I store my screenshots on the desktop, so start here
  cd ~/desktop

  if [ "$4" = 'annotate' ]
  then
    # Annotate adding the Before/After text if annotate flag is passed
    convert "$1" -undercolor white -pointsize 66 -fill red  -gravity Northwest -annotate 0 'Before' "$1"
    convert "$2" -undercolor white -pointsize 66 -fill "#78BE21"  -gravity Northwest -annotate 0 'After' "$2"
  fi

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
    # Upload to Cloudinary and then copy the HTTPS image link to clipboard (using the cld uploader)
    cld uploader upload ~/desktop/result.jpg | jq -r '.secure_url' | pbcopy
  fi
}

# Check weather using "weather Cityname"
weather() {
    city="$1"

    if [ -z "$city" ]; then
        city="Lidköping"
    fi

    eval "curl http://wttr.in/${city}"
}

# Check size of files
# Handy to check bundle sizes, built assets etc.
# Pass in a file path ex. sz path/to/file.css
function sz() {
  du -d 1 -h "$1" | cut -f1
}

function szgzip() {
  gzip -c "$1" | wc -c | awk '{$1/=1024;printf "%.2fK\n",$1}'
}

# Convert mp4 to GIF with ffmpeg
# Usage: togif "validation.mp4" "output" 25 1.5
togif() {
  # Required arguments
  input_file="$1"
  output_file="$2"

  # Optional arguments with default values
  framerate="${3:-30}"
  pts="${4:-2}"

  ffmpeg -i "$input_file" -vf "setpts=PTS/$pts,fps=$framerate,scale=1520:-1:flags=lanczos" -c:v pam -f image2pipe - \
  | convert -delay 5 - -loop 0 -layers optimize "$output_file.gif"
}
