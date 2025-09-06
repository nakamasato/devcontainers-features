#!/bin/bash

set -e

echo "Installing tig..."

# OSの検出
. /etc/os-release

# Debian/Ubuntu系
if [ "${ID}" = "ubuntu" ] || [ "${ID}" = "debian" ]; then
    apt-get update
    apt-get install -y tig

# Alpine系
elif [ "${ID}" = "alpine" ]; then
    apk update
    apk add --no-cache tig

else
    echo "Unsupported OS: ${ID}"
    exit 1
fi

echo "Tig installed successfully!"
