#!/bin/bash

# OpenJDK 17 Installer

set -e
source utils/logger.sh

log_info "Installing OpenJDK 17..."

sudo apt-get update
sudo apt-get install -y openjdk-17-jdk

log_info "Java version: $(java -version 2>&1 | head -n 1)"