#!/bin/bash

# React Installer via Create React App
# Official: https://create-react-app.dev/docs/getting-started/
set -e
source utils/logger.sh

log_info "Installing Create React App (React CLI)..."

# Ensure Node.js is installed
if ! command -v npm &>/dev/null; then
  log_error "npm not found. Install Node.js first."
  exit 1
fi

# Install CRA globally
sudo npm install -g create-react-app

log_info "Create React App installed: $(create-react-app --version)"