#!/usr/bin/env bash

declare KEYID="${1}"
declare -a keyservers=(185.125.188.26 18.9.60.141 keys.openpgp.org)

echo "Sending key: ${KEYID}..."
for ks in "${keyservers[@]}"; do
    gpg --verbose --keyserver "hkp://${ks}" --send-keys "${KEYID}"
done

echo "Refreshing keys..."
for ks in "${keyservers[@]}"; do
    gpg --verbose --keyserver "hkp://${ks}" --refresh-keys
done
