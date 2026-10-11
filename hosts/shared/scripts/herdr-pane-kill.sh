#!/usr/bin/env bash

declare PANE
declare paneID

PANE="$1"

if [[ -z "${PANE}" ]]; then
  herdr pane list | jq -r '.result.panes[] | [.pane_id, .label] | @tsv'
else
  paneID=$(herdr pane list | jq -r ".result.panes[] | select(.pane_id == \"${PANE}\" or .label == \"${PANE}\") | .pane_id")
  if [[ -z "${paneID}" ]]; then
    echo "No pane matching ${PANE}" 2>/dev/null
    exit 1
  fi
  herdr pane close "${paneID}"
fi
