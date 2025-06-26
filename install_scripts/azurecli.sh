#!/bin/bash

# Azure CLI Installer via Microsoft apt repo

set -e
source utils/logger.sh

log_info "Installing Azure CLI..."

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

log_info "Azure CLI installed: $(az version | head -n1)"