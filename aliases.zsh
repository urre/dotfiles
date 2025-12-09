# Load some .env secrets
DIR="$HOME/.dotfiles"
if [ -f "$DIR/.env" ]; then
  source "$DIR/.env"
else
  echo "Warning: $DIR/.env file not found, skipping environment variable loading."
fi

# General
alias cls="clear"
alias size="du -k -a | sort -n"
alias iip="ipconfig getifaddr en0"
alias eip="curl icanhazip.com"
alias reload=". ~/.zshrc"
alias prev="cd -"

# Work
alias gw="./gradlew"
alias dr="./debug/run"
alias rebuild="git submodule update --init --recursive && ./gradlew stopAll && rm -rf ${PROJECTS_DIRECTORY}/idsvr/dist && ./gradlew packageDebug --parallel && ln -s ${PROJECTS_DIRECTORY}/curity-web-ui/dist/browser ${PROJECTS_DIRECTORY}/idsvr/dist/etc/admin-webui"
alias reloadconfig="cd ${PROJECTS_DIRECTORY}/idsvr/dist/bin && ./idsvr -f && cd -"
alias enabledevops="cd ${PROJECTS_DIRECTORY}/curity-web-ui/devops-dashboard && npx cypress run --spec cypress/e2e/EnableDashboard.ts"
alias resym="ln -s ${PROJECTS_DIRECTORY}/curity-web-ui/dist/browser ${PROJECTS_DIRECTORY}/idsvr/dist/etc/admin-webui"
alias t="curity-cli t"

# Cat with syntax highlighting using ccat
alias cat='ccat'

# Load config from a file
loadconfig() {
    local input="$1"
    if [ -z "$input" ]; then
        echo "Error: XML file input path is required"
        return 1
    fi
    if [ -z "$IDSVR_DIRECTORY" ]; then
        echo "Error: IDSVR_DIRECTORY is not set"
        return 1
    fi

    "${IDSVR_DIRECTORY}/dist/bin/idsh" --noninteractive << EOF
        configure
        load merge ${input}
        commit
        exit no-confirm
        exit
EOF
}

# Launch dev standup on Zoom
function sdev() {
  clear
  echo "Launching Zoom..."
  open "zoommtg://zoom.us/join?action=join&confno=${ZOOM_DEV_STANDUP_CONF_NO}&pwd=${ZOOM_STANDUP_PASSWORD}"
}

# Launch PMe/Marketing standup on Zoom
function spme() {
  clear
  echo "Launching Zoom..."
  open "zoommtg://zoom.us/join?action=join&confno=${ZOOM_PME_STANDUP_CONF_NO}&pwd=${ZOOM_STANDUP_PASSWORD}"
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
alias dk='docker kill $(docker ps -q)'
alias ddi='docker rmi $(docker images -q)'
alias ds='docker stop $(docker ps -a -q)'
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


# Add ,notify after a command to get a macOS notification when the command completes
,notify () {
  local last_exit_status="$?"

  if [[ "$last_exit_status" == '0' ]]; then
    osascript -e "display notification \"Done\" with title \"Good\" sound name \"Fonk\""
  else
    osascript -e "display notification \"Exit code: $last_exit_status\" with title \"Bad\" sound name \"Ping\""
  fi
  $(exit "$last_exit_status")
}

# Show free space on a volume
diskfree() {
    df -h "$1" | awk 'NR==2 {
        total=$2; used=$3; avail=$4;
        gsub(/Gi/, "GB", total); gsub(/Gi/, "GB", used); gsub(/Gi/, "GB", avail);
        gsub(/Mi/, "MB", total); gsub(/Mi/, "MB", used); gsub(/Mi/, "MB", avail);
        gsub(/Ti/, "TB", total); gsub(/Ti/, "TB", used); gsub(/Ti/, "TB", avail);
        freePct = ($4+0)/($2+0)*100;
        printf "\033[1;32mAvailable:\033[0m %s\n\033[1;36mTotal:\033[0m %s\n\033[1;33mFree:\033[0m %.1f%%\n", avail, total, freePct
    }'
}

# Repeat a command at a specified interval (in seconds)
# Usage: runevery 5 npm run build
runevery() {
  if [[ $# -lt 2 ]]; then
    echo "Usage: runevery <interval> <command> [args...]"
    return 1
  fi

  local interval=$1
  shift

  while true; do
    "$@" &
    sleep "$interval"
  done
}
