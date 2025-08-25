if [[ "$1" == "ts" ]]; then
    echo "SSH proxy running in Tailscale mode..."
    ssh -D 1080 "ubuntu@rpi4-standalone" -N
else
    echo "SSH proxy running..."
    ssh -D 1080 "ubuntu@192.168.148.244" -N
fi
