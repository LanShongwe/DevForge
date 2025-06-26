#!/bin/bash

# PostgreSQL Installer (v15) from Apt Repository
# Official guide: https://www.postgresql.org/download/linux/ubuntu

set -e
source utils/logger.sh

log_info "Installing PostgreSQL 15..."

# Install prerequisites
sudo apt-get update
sudo apt-get install -y wget ca-certificates

# Add PostgreSQL APT repository
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" \
  | sudo tee /etc/apt/sources.list.d/pgdg.list

# Install PostgreSQL
sudo apt-get update
sudo apt-get install -y postgresql-15

# Start & enable service
sudo systemctl enable postgresql
sudo systemctl start postgresql

log_info "PostgreSQL 15 installed."