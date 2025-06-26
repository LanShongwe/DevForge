#!/bin/bash
# Author: DevForge Installer
# Description: Installs MongoDB 8.0 Community Edition on Ubuntu 20.04/22.04/24.04
# Architecture: x86_64 and arm64 supported
# Last Updated: 2025-06-26
# Reference: https://www.mongodb.com/docs/manual/tutorial/install-mongodb-on-ubuntu/

set -e

# Includes logger
source ./utils/logger.sh

log_info "🟢 Starting MongoDB 8.0 Installation"

# Check if already installed
if command -v mongod &>/dev/null; then
    log_warn "MongoDB is already installed. Skipping."
    exit 0
fi

# Determine Ubuntu release
UBUNTU_VERSION=$(lsb_release -rs)
log_info "Detected Ubuntu version: $UBUNTU_VERSION"

# Install dependencies
log_info "Installing gnupg and curl..."
sudo apt-get update
sudo apt-get install -y gnupg curl

# Add GPG key
log_info "Importing MongoDB GPG key..."
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
  sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor

# Add appropriate repo based on version
case "$UBUNTU_VERSION" in
  "24.04")
    DISTRO="noble"
    ;;
  "22.04")
    DISTRO="jammy"
    ;;
  "20.04")
    DISTRO="focal"
    ;;
  *)
    log_error "Unsupported Ubuntu version: $UBUNTU_VERSION"
    exit 1
    ;;
esac

log_info "Adding MongoDB APT repository for $DISTRO..."
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu $DISTRO/mongodb-org/8.0 multiverse" | \
  sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list

# Reload APT and install
log_info "Updating APT sources..."
sudo apt-get update

log_info "Installing MongoDB 8.0 Community Edition..."
sudo apt-get install -y mongodb-org

# Enable and start service
log_info "Enabling and starting MongoDB service..."
sudo systemctl daemon-reexec || true
sudo systemctl start mongod
sudo systemctl enable mongod

# Verify status
log_info "Verifying MongoDB status..."
sudo systemctl status mongod --no-pager

# Create log entry
log_info "✅ MongoDB installation complete and service is running."

# Environment test
log_info "Launching mongosh (shell)..."
mongosh --eval 'db.runCommand({ connectionStatus: 1 })' || \
  log_warn "Mongo shell test failed. Please run 'mongosh' manually."

exit 0