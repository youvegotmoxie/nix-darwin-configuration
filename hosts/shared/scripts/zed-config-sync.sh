#!/user/bin/env bash

# There are API keys in the Zed settings file so these can't be stored in git
# because I don't have it in me to SOPS round 2

for i in settings keymap tasks; do
  echo "Copied ${i}.json to the password store"
  pass add -m -f "Zed/config-sync/${i}.json" <~/.config/zed/${i}.json 1>/dev/null
done
