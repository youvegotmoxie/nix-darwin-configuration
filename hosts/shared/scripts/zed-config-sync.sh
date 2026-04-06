#!/usr/bin/env bash

# There are API keys in the Zed settings file so these can't be stored in git
# because I don't have it in me to SOPS round 2

# Diff the configs in the password store against the local Zed configs
function diff_change() {

  for i in settings keymap tasks; do
    OUTPUT=$(diff -u ~/.config/zed/${i}.json <(pass show "Zed/config-sync/${i}.json"))

    if [ -z "${OUTPUT}" ]; then
      echo "No changes to ${i}.json"
    else
      echo "${OUTPUT}"
    fi
  done

}

# Replace local Zed configs with the ones from the password store
function pull_changes() {

  for i in settings keymap tasks; do
    pass show "Zed/config-sync/${i}.json" >~/.config/zed/${i}.json
    echo "Restored ${i}.json from the password store"
  done

}

function push_changes() {

  for i in settings keymap tasks; do
    echo "Copied ${i}.json to the password store"
    pass add -m -f "Zed/config-sync/${i}.json" <~/.config/zed/${i}.json 1>/dev/null
  done

}

# Only need to care about the GitHub API keys
# Default to my personal key since I'd rather break the editor at work
# than allow my personal laptop access to work GitHub
function swap_secret() {
  INPUT="${1:-personal}"
  SECRET=$(pass show "Zed/api-keys/github-${INPUT}-key")
  echo "Replacing secret with ${INPUT} key"
  sed -i "s|ghp_.*|$SECRET\",|" ~/.config/zed/settings.json
}

case "$1" in
--dry-run)
  diff_change
  ;;
--apply)
  pull_changes
  ;;
--push)
  push_changes
  ;;
--swap-secret)
  swap_secret "${2}"
  shift
  ;;
--help)
  echo "Use --dry-run to preview changes"
  echo "Use --apply to apply changes"
  echo "Use --push to push changes to the password store"
  echo "Use --swap-secret to replace a secret in Zed's config from the password store"
  exit 0
  ;;
*)
  echo "Invalid option. See --help for usage"
  exit 0
  ;;
esac
