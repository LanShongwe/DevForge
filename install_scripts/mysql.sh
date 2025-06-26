#!/bin/bash

# MySQL Installer (default version from repo)

set -e
source utils/logger.sh

log_info "Installing MySQL server..."

sudo apt-get update
sudo apt-get install -y mysql-server

sudo systemctl enable mysql
sudo systemctl start mysql

log_info "MySQL installed and running."