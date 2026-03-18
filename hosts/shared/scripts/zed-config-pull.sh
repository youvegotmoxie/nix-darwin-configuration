#!/usr/bin/env bash

# Diff local Zed configs against the password store and apply them (optionally)

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

function pull_changes() {
  for i in settings keymap tasks; do
    pass show "Zed/config-sync/${i}.json" >~/.config/zed/${i}.json
    echo "Restored ${i}.json from the password store"
  done
}

case "$@" in
--dry-run)
  diff_change
  shift
  ;;
--apply)
  pull_changes
  shift
  ;;
*)
  echo "Use --dry-run to preview changes or --apply to apply changes"
  exit 0
  ;;
esac
