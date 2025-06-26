#!/bin/bash

# Terraform Installer (Linux)
# https://learn.hashicorp.com/tutorials/terraform/install-cli

set -e
source utils/logger.sh

TERRAFORM_VERSION="1.5.7"

log_info "Installing Terraform version $TERRAFORM_VERSION..."

cd /tmp
curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

sudo apt-get install -y unzip

unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

log_info "Terraform installed successfully."
terraform -version