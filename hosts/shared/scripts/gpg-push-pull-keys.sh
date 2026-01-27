#!/usr/bin/env bash

declare KEYID="${1}"
declare -a keyservers=(keyserver.ubuntu.com pgp.mit.edu keys.openpgp.org)

echo "Sending key: ${KEYID}..."
for ks in "${keyservers[@]}"; do
    gpg --keyserver "${ks}" --send-keys "${KEYID}"
done

echo "Refreshing keys..."
for ks in "${keyservers[@]}"; do
    gpg --keyserver "${ks}" --refresh-keys
done
