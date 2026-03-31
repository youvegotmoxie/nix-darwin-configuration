#!/usr/bin/env bash
declare host
host="${1:-ubuntu-dev-pod-0}"

ssh -N -L 10350:localhost:10350 "${host}"
