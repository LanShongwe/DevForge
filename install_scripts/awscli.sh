#!/bin/bash

# AWS CLI v2 Installer for Linux x86_64
# Official: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

set -e
source utils/logger.sh

log_info "Installing AWS CLI v2..."

curl "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o awscliv2.zip
unzip awscliv2.zip
sudo ./aws/install --update

log_info "AWS CLI installed: $(aws --version)"