# Aliases
# Very good completion system
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

# Sort commiters by number of commits
function git-stats() {
    git log | grep '^Author' | sort | uniq -ci | sort -r
}

# Show git status
function git-staged() {
    git status 2> /dev/null | grep "nothing to commit"
    echo $?
}

# Commit and push changes
function git-sendit() {
    local branch="$(git branch --show-current)"
    git add .

    if [ ! -z "$1" ]; then
        local msg="trivial"
        git commit -m ${msg} -S
    else
        git commit -S
    fi

    git push "${origin}" "${branch}"
}

# Clean all unused Docker images
function docker-clean-images() {
    for i in $(docker image list | awk '{ print $3 }' | grep -v  IMAGE | sed -e '/^\s*$/g'); do
        docker image rm -f "${i}" 2>&1 > /dev/null
    done
}


function bwlunlock () {
  export BW_PASSWD=$(cat ~/.creds.d/BW_PASSWD)
  export BW_SESSION=$(bw unlock --passwordenv BW_PASSWD --raw)
}

# Color pager
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Unset terminal bell
unsetopt beep
unsetopt hist_beep
