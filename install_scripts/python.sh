#!/bin/bash

# Official Python Installer

set -e
source utils/logger.sh

log_info "Installing Python 3 and pip..."

sudo apt-get update
sudo apt-get install -y python3 python3-venv python3-pip

log_info "Python version: $(python3 --version)"