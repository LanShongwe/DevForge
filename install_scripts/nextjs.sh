#!/bin/bash

# Next.js CLI Installer
# Based on Next.js documentation: https://nextjs.org/docs

set -e
source utils/logger.sh

log_info "Installing Next.js CLI globally via npm..."

# Ensure Node is installed
if ! command -v npm &> /dev/null; then
  log_error "npm not installed. Ensure Node.js is installed first."
  exit 1
fi

# Install Next CLI
sudo npm install -g create-next-app

log_info "Next.js CLI installed: $(create-next-app --version)"