#!/bin/bash

# .NET SDK Installer (6+)

set -e
source utils/logger.sh

log_info "Installing .NET SDK..."

wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt-get update
sudo apt-get install -y apt-transport-https
sudo apt-get update
sudo apt-get install -y dotnet-sdk-6.0

log_info ".NET SDK version: $(dotnet --version)"