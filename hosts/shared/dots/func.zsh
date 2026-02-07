# shellcheck disable=SC2148
# Very good completion system
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

# Clean all unused Docker images
function docker-clean-images() {
    for i in $(docker image list | awk '{ print $3 }' | grep -v  IMAGE | sed -e '/^\s*$/g'); do
        # shellcheck disable=SC2069
        docker image rm -f "${i}" 2>&1 > /dev/null
    done
}

# Auto decode Kubernetes secrets
function kxsec(){
  tmpl='{{range $k,$v := .data}}{{printf "%s: " $k}}{{if not $v}}{{$v}}{{else}}{{$v | base64decode}}{{end}}{{"\n"}}{{end}}'
  if [ -n "$2" ]; then
    tmpl="{{ index .data \"$2\"| base64decode }}"
  fi
  kubectl get secret $1  -o go-template="$tmpl"
}

_kxsec() {
  local -a secrets
  secrets=(${(f)"$(kubectl get secrets -o jsonpath='{.items[*].metadata.name}')"})

  # Completion for keys in the selected secret
  _secret_keys() {
    local secret=$words[2]
    local -a keys
    if [[ -n $secret ]]; then
      keys=(${(f)"$(kubectl get secret $secret -o jsonpath='{.data}' | jq -r 'keys[]' 2>/dev/null)"})
      _describe 'key' keys
    fi
  }
  _arguments \
    "1:secret-name:(${secrets[*]})" \
    "2:key-name:_secret_keys" \
    '*:file:_files'
}

compdef _kxsec kxsec

# Color pager
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export KUBECOLOR_OBJ_FRESH="10h"

# Unset terminal bell
unsetopt beep
unsetopt hist_beep
