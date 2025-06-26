#!/bin/bash

# htop System Monitor Installer

set -e
source utils/logger.sh

log_info "Installing htop..."

sudo apt-get update
sudo apt-get install -y htop

log_info "htop installed successfully."