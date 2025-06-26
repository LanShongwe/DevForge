#!/bin/bash

# Git Installer

set -e
source utils/logger.sh

log_info "Installing Git..."

sudo apt-get update
sudo apt-get install -y git

log_info "Git version: $(git --version)"
