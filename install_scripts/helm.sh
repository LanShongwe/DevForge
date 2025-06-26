#!/bin/bash

# Helm Installer (Linux)
# https://helm.sh/docs/intro/install/

set -e
source utils/logger.sh

HELM_VERSION="v3.12.3"  # update if needed

log_info "Installing Helm $HELM_VERSION..."

curl -LO https://get.helm.sh/helm-$HELM_VERSION-linux-amd64.tar.gz
tar -zxvf helm-$HELM_VERSION-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
rm -rf linux-amd64 helm-$HELM_VERSION-linux-amd64.tar.gz

log_info "Helm installed successfully."
helm version