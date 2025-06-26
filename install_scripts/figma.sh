#!/bin/bash

# Figma Linux Installer via Flatpak

set -e
source utils/logger.sh

log_info "Installing Figma via Flatpak..."

sudo apt-get update
sudo apt-get install -y flatpak

flatpak install -y flathub com.figma.Desktop

log_info "Figma installed via Flatpak."