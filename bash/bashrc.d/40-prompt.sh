# ---- 40-prompt.sh ----
# Interactive bash prompt with Git info (safe)

# Exit early if not interactive
[[ $- != *i* ]] && return

# Set up basic colors (fallback if tput fails)
if command -v tput &>/dev/null; then
    bold=$(tput bold)
    reset=$(tput sgr0)
    black=$(tput setaf 0)
    red=$(tput setaf 1)
    green=$(tput setaf 2)
    yellow=$(tput setaf 3)
    blue=$(tput setaf 4)
    magenta=$(tput setaf 5)
    cyan=$(tput setaf 6)
    white=$(tput setaf 7)
else
    bold=""
    reset="\e[0m"
    black="\e[1;30m"
    red="\e[1;31m"
    green="\e[1;32m"
    yellow="\e[1;33m"
    blue="\e[1;34m"
    magenta="\e[1;35m"
    cyan="\e[1;36m"
    white="\e[1;37m"
fi

# Function to get Git branch and status
prompt_git() {
    command -v git &>/dev/null || return
    git rev-parse --is-inside-work-tree &>/dev/null || return

    local branch status=""
    branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null \
          || git rev-parse --short HEAD 2>/dev/null) || return

    ! git diff --cached --quiet 2>/dev/null && status+="+"
    ! git diff-files --quiet 2>/dev/null && status+="!"
    [ -n "$(git ls-files --others --exclude-standard 2>/dev/null)" ] && status+="?"
    git rev-parse --verify refs/stash &>/dev/null && status+="$"

    printf " on %s" "$branch"
    [ -n "$status" ] && printf "[%s]" "$status"
}

# Highlight user and host
user_color=$yellow
[[ "$USER" == "root" ]] && user_color=$red
host_color=$green
[[ -n "$SSH_TTY" ]] && host_color="${bold}${red}"

# Set PS1
PS1="\n${bold}${user_color}\u${reset}@${host_color}\h${reset}:${blue}\w${reset}"
PS1+="\$(prompt_git) \$ "

# Optional secondary prompt
PS2="→ "
export PS1 PS2

