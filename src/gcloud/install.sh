#!/bin/bash

set -e

echo "Installing Google Cloud SDK..."

# OSの検出
. /etc/os-release

# 必要なパッケージのインストール
if [ "${ID}" = "ubuntu" ] || [ "${ID}" = "debian" ]; then
    apt-get update
    apt-get install -y curl python3 python3-pip

    # Google Cloud SDK をダウンロードしてインストール（aptの依存関係問題を回避）
    ARCH=$(uname -m)
    if [ "${ARCH}" = "x86_64" ]; then
        GCLOUD_ARCH="x86_64"
    elif [ "${ARCH}" = "aarch64" ] || [ "${ARCH}" = "arm64" ]; then
        GCLOUD_ARCH="arm"
    else
        echo "Unsupported architecture: ${ARCH}"
        exit 1
    fi

    curl -O "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-${GCLOUD_ARCH}.tar.gz"
    tar -xf "google-cloud-cli-linux-${GCLOUD_ARCH}.tar.gz" -C /usr/local
    /usr/local/google-cloud-sdk/install.sh --quiet --path-update=false
    rm "google-cloud-cli-linux-${GCLOUD_ARCH}.tar.gz"

    # パスを設定
    ln -sf /usr/local/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud
    ln -sf /usr/local/google-cloud-sdk/bin/gsutil /usr/local/bin/gsutil
    ln -sf /usr/local/google-cloud-sdk/bin/bq /usr/local/bin/bq

# Alpine系
elif [ "${ID}" = "alpine" ]; then
    apk update
    apk add --no-cache curl python3 py3-pip

    # Google Cloud SDK をダウンロードしてインストール
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz
    tar -xf google-cloud-cli-linux-x86_64.tar.gz -C /usr/local
    /usr/local/google-cloud-sdk/install.sh --quiet --path-update=true
    rm google-cloud-cli-linux-x86_64.tar.gz

    # パスを設定
    ln -s /usr/local/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud

else
    echo "Unsupported OS: ${ID}"
    exit 1
fi

echo "Google Cloud SDK installed successfully!"
