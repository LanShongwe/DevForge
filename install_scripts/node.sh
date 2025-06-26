#!/bin/bash

# Node.js Installer (LTS) via NodeSource RPM
# Official guide: https://github.com/nodesource/distributions

set -e
source utils/logger.sh

log_info "Installing Node.js LTS..."

# Download and run NodeSource setup
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -

# Install Node.js
sudo apt-get install -y nodejs

log_info "Node.js installed: $(node -v)"
