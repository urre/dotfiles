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

# Create a Jira ticket
jiraticket() {

  # Use "Task", the ID is 3
  local ISSUE_TYPE=3

  # Project CW and IS supported
  local pid
  case "$1" in
    cw) pid=11600 ;;
    is) pid=11200 ;;
    *)
      echo "Usage: jiraticket {cw|is}"
      return 1
      ;;
  esac

  local url="https://curity.atlassian.net/secure/CreateIssueDetails!init.jspa?pid=$pid&issuetype=$ISSUE_TYPE"
  open "$url" 2>/dev/null || xdg-open "$url"
}

# Open Google Meet links
function meet() {
  local base_url="https://meet.google.com"
  local meeting
  case "$1" in
    picard)
      meeting="${base_url}/ekj-ekqv-krd"
      ;;
    dev)
      meeting="${base_url}/tij-aejm-dyo"
      ;;
    pme)
      meeting="${base_url}/dyc-aqer-hrm"
      ;;
    kirk)
      meeting="${base_url}/pzx-mjij-hrw"
      ;;
    *)
      echo "Usage: meet {picard|dev|pme|kirk}"
      return 1
      ;;
  esac

  clear
  echo "Opening Google Meet..."
  open "$meeting"
}


# Java
# The openjdk@X is keg-only; we need to create a symbolic link so that the macOS java wrapper can find it.
# https://docs.brew.sh/FAQ#what-does-keg-only-mean

function java21() {
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-21.jdk/Contents/Home
  export PATH="$JAVA_HOME/bin:$PATH"
}
