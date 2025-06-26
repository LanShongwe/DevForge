#!/bin/bash

# Google Cloud SDK Installer

set -e
source utils/logger.sh

log_info "Installing Google Cloud SDK..."

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | \
  sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

sudo apt-get update
sudo apt-get install -y google-cloud-sdk

log_info "gcloud installed: $(gcloud --version | head -n1)"