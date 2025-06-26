#!/bin/bash

# Visual Studio Code Installer
# Based on official Microsoft documentation
# https://code.visualstudio.com/docs/setup/linux

set -e

source utils/logger.sh

log_info "Installing Visual Studio Code..."

# Ensure dependencies
sudo apt-get install -y wget gpg apt-transport-https

# Add Microsoft GPG key
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -D -o root -g root -m 644 microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
rm -f microsoft.gpg

# Add repo
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

# Update and install
sudo apt update
sudo apt install -y code

log_info "Visual Studio Code installed successfully."