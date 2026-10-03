#!/usr/bin/env bash

declare MACHINE
declare machineID
declare machineStatus

MACHINE="$1"
machineID=$(herdr machine list --json | jq -r ".[] | select(.label == \"${MACHINE}\") | .id")
machineStatus=$(herdr machine list --json | jq -r ".[] | select(.label == \"${MACHINE}\") | .enabled")

if [[ "${machineStatus}" == "true" ]]; then
  herdr machine disable "${machineID}"
else
  herdr machine enable "${machineID}"
fi
