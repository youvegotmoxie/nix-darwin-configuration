#!/usr/bin/env bash
if [[ "$1" == "local" ]]; then
    echo "SSH proxy running in Tailscale mode... (port 2080)"
    ssh -D 2080 "rpi4-timemachine" -N
else
    echo "SSH proxy running... (port 1080)"
    ssh -D 1080 "iad-jump" -N
fi
