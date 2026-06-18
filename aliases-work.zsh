# Work
alias gw="./gradlew"
alias dr="./debug/run"
alias t="curity-cli t"
alias curity='clear && figlet CURITY | while IFS= read -r line; do printf "\033[38;2;216;89;161m%s\033[0m\n" "$line"; done'

# Build idsvr, reload config and enable DevOps Dashboard
alias rebuild="git submodule update --init --recursive && ./gradlew stopAll && rm -rf ${PROJECTS_DIRECTORY}/idsvr/dist && ./gradlew packageDebug --parallel"
alias reloadconfig="cd ${PROJECTS_DIRECTORY}/idsvr/dist/bin && ./idsvr -f && cd -"
alias enabledevops="cd ${PROJECTS_DIRECTORY}/idsvr/curity-web-ui/devops-dashboard && npx cypress run --spec cypress/e2e/EnableDashboard.ts"

# Load config from .xml file
loadconfig() {
  "${IDSVR_DIRECTORY}/dist/bin/idsh" --noninteractive <<EOF
configure
load merge $1
commit
exit no-confirm
exit
EOF
}

# Create a Jira ticket
# Usage: jiraticket <project> <summary>
# Example: jiraticket CW "Fix login redirect loop"
jiraticket() {
  acli rovodev run "Create a Jira issue in project ${1}. Type: Task. Summary: ${2}"
}
