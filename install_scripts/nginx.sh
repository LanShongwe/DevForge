#!/bin/bash

# Nginx Web Server Installer

set -e
source utils/logger.sh

log_info "Installing Nginx..."

sudo apt-get update
sudo apt-get install -y nginx

sudo systemctl enable nginx
sudo systemctl start nginx

log_info "Nginx installed and running."