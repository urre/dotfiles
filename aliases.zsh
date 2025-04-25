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
alias rebuild="git submodule update && ./gradlew stopAll && rm -rf ${PROJECTS_DIRECTORY}/idsvr/dist && ./gradlew packageDebug --parallel && ln -s ${PROJECTS_DIRECTORY}/curity-web-ui/dist/browser ${PROJECTS_DIRECTORY}/idsvr/dist/etc/admin-webui"
alias reloadconfig="cd ${PROJECTS_DIRECTORY}/idsvr/dist/bin && ./idsvr -f"
alias enabledevops="cd ${PROJECTS_DIRECTORY}/curity-web-ui/devops-dashboard && npx cypress run --spec cypress/e2e/EnableDashboard.ts"
alias resym="ln -s ${PROJECTS_DIRECTORY}/curity-web-ui/dist/browser ${PROJECTS_DIRECTORY}/idsvr/dist/etc/admin-webui"
alias t="curity-cli t"

# Load config from a file
loadconfig() {
    local input="$1"
    if [ -z "$input" ]; then
        echo "Error: XML file input path is required"
        return 1
    fi
    if [ -z "$PROJECTS_DIRECTORY" ]; then
        echo "Error: PROJECTS_DIRECTORY is not set"
        return 1
    fi

    "${PROJECTS_DIRECTORY}/idsvr/dist/bin/idsh" --noninteractive << EOF
        configure
        load merge ${input}
        commit
        exit no-confirm
        exit
EOF
}

# Java
# The openjdk@X is keg-only; we need to create a symbolic link so that the macOS java wrapper can find it.
# https://docs.brew.sh/FAQ#what-does-keg-only-mean

function java21() {
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-21.jdk/Contents/Home
  export PATH="$JAVA_HOME/bin:$PATH"
}

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

# Git Standup
function gitStandup() {
    local days=$1
    if [[ -z $days ]]; then
        echo "Usage: git_standup <number of days>"
        return 1
    fi

    cd "${PROJECTS_DIRECTORY}"
    git standup -a "Urban Sandén" -m 5 -w "$days" -s
}


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

# Activate/deactivate ./git/hooks/prepare-commit-msg hook
togglePrepareCommitHook() {
    hook_path=".git/hooks/prepare-commit-msg"
    backup_path=".git/hooks/prepare-commit-msg-BAK"

    if [ -f "$hook_path" ]; then
        if [ -f "$backup_path" ]; then
            echo "Error: Backup file already exists. Aborting."
            return 1
        fi

        mv "$hook_path" "$backup_path"
        echo "Prepare-commit-msg hook deactivated."
    else
        if [ ! -f "$backup_path" ]; then
            echo "Error: No backup file found. Aborting."
            return 1
        fi

        mv "$backup_path" "$hook_path"
        echo "Prepare-commit-msg hook activated."
    fi
}

# Update the authToken for curity-npm-group-registry, used for publishing npm packages
# When using curity-cli t, only the curity-npm-group is updated. This function updates curity-npm-group-registry so it's using the same token
update_npmrc_token() {
  local npmrc="$HOME/.npmrc"
  local first_token
  local second_token

  # Extract the first auth token
  first_token=$(grep "//hub.curityio.net/repository/curity-npm-group/:_authToken=" "$npmrc" | cut -d'=' -f2)

  # Check if the first token exists
  if [[ -z "$first_token" ]]; then
    echo "First auth token not found!"
    return 1
  fi

  # Update the second auth token to match the first
  sed -i.bak "s#//hub.curityio.net/repository/curity-npm-registry/:_authToken=.*#//hub.curityio.net/repository/curity-npm-registry/:_authToken=${first_token}#" "$npmrc"

  echo "Updated curity-npm-registry auth token to match the curity-npm-group-registry"
}

,notify () {
  local last_exit_status="$?"

  if [[ "$last_exit_status" == '0' ]]; then
    osascript -e "display notification \"Done\" with title \"Good\" sound name \"Fonk\""
  else
    osascript -e "display notification \"Exit code: $last_exit_status\" with title \"Bad\" sound name \"Ping\""
  fi
  $(exit "$last_exit_status")
}

# Download YouTube videos to my Plex server using yt-dlp
dlv() {
  yt-dlp -f "bestvideo[height>=720]+bestaudio/best[height>=720]" --merge-output-format mkv -P "/Volumes/Videos" "$1"
}
