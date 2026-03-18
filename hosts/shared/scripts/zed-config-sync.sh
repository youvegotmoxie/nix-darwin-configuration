#!/usr/bin/env bash

# There are API keys in the Zed settings file so these can't be stored in git
# because I don't have it in me to SOPS round 2

# Diff the configs in the password store against the local Zed configs

function diff_change() {

  for i in settings keymap tasks; do
    output=$(diff -u ~/.config/zed/${i}.json <(pass show "Zed/config-sync/${i}.json"))

    if [ -z "${output}" ]; then
      echo "No changes to ${i}.json"
    else
      echo "${output}"
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

case "$@" in
--dry-run)
  diff_change
  ;;
--apply)
  pull_changes
  ;;
--push)
  push_changes
  ;;
--help)
  echo "Use --dry-run to preview changes"
  echo "Use --apply to apply changes"
  echo "Use --push to push changes to the password store"
  exit 0
  ;;
*)
  echo "Invalid option. See --help for usage"
  exit 0
  ;;
esac
