#!/bin/bash

# Apache Maven Installer

set -e
source utils/logger.sh

log_info "Installing Maven..."

sudo apt-get update
sudo apt-get install -y maven

log_info "Maven version: $(mvn -version | head -n 1)"