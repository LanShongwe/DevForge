#!/bin/bash

# Postman Installer via Snap (official method)
# https://snapcraft.io/postman

set -e

source utils/logger.sh

log_info "Installing Postman..."

# Install snapd if not already
if ! command -v snap &>/dev/null; then
    log_info "Snap not found. Installing snapd..."
    sudo apt update
    sudo apt install -y snapd
fi

# Install Postman via Snap
sudo snap install postman

log_info "Postman installed successfully."