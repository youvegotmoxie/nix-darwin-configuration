#!/usr/bin/env bash

# Capture changes before overwriting the local configs
for i in settings keymap tasks; do
  echo "Diff for ${i}.json:"
  diff -u ~/.config/zed/${i}.json <(pass show "Zed/config-sync/${i}.json")

  pass show "Zed/config-sync/${i}.json" >~/.config/zed/${i}.json
  echo "Restored ${i}.json from the password store"
done
