#!/bin/bash

set -e

echo "Installing Google Cloud SDK..."

# OSの検出
. /etc/os-release

# 必要なパッケージのインストール
if [ "${ID}" = "ubuntu" ] || [ "${ID}" = "debian" ]; then
    apt-get update
    apt-get install -y curl apt-transport-https ca-certificates gnupg

    # Google Cloud public key をインポート
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

    # Google Cloud SDK リポジトリを追加
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

    # Google Cloud SDK をインストール
    apt-get update
    apt-get install -y google-cloud-cli

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
