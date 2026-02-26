# Work
alias gw="./gradlew"
alias dr="./debug/run"
alias t="curity-cli t"

# Git
alias recent="git for-each-ref --sort=committerdate --format='%(color:yellow)%(committerdate:relative)%(color:reset) %(color:green)%(refname:short)%(color:reset)' --color=always refs/heads/ | tail -10"

# Build idsvr, reload config and enable DevOps Dashboard
alias rebuild="git submodule update --init --recursive && ./gradlew stopAll && rm -rf ${PROJECTS_DIRECTORY}/idsvr/dist && ./gradlew packageDebug --parallel"
alias reloadconfig="cd ${PROJECTS_DIRECTORY}/idsvr/dist/bin && ./idsvr -f && cd -"
alias enabledevops="cd ${PROJECTS_DIRECTORY}/idsvr/curity-web-ui/devops-dashboard && npx cypress run --spec cypress/e2e/EnableDashboard.ts"

# Load config from .xml file
loadconfig() {
  "${IDSVR_DIRECTORY}/dist/bin/idsh" --noninteractive <<< "configure\nload merge $1\ncommit\nexit no-confirm\nexit"
}

# Create a Jira ticket
# Usage: jiraticket <project> <summary>
# Example: jiraticket CW "Fix login redirect loop"
jiraticket() {
  local project="${1:?Usage: jiraticket <project> <summary>}"
  local summary="${2:?Usage: jiraticket <project> <summary>}"
  acli rovodev run "Create a Jira issue in project ${project}. Type: Task. Summary: ${summary}"
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

  # clear
  echo "Opening Google Meet..."
  # open "$meeting" -a "Google Meet"
  open "$meeting"
}


# Java
# The openjdk@X is keg-only; we need to create a symbolic link so that the macOS java wrapper can find it.
# https://docs.brew.sh/FAQ#what-does-keg-only-mean

function java21() {
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-21.jdk/Contents/Home
  export PATH="$JAVA_HOME/bin:$PATH"
}
