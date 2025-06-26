#!/bin/bash

# Grafana Installer (Ubuntu)
# Based on official docs: https://grafana.com/docs/grafana/latest/installation/debian/

set -e
source utils/logger.sh

log_info "Installing Grafana..."

# Add GPG key and repo
sudo apt-get install -y software-properties-common wget
wget -q -O - https://packages.grafana.com/gpg.key | sudo tee /usr/share/keyrings/grafana.key >/dev/null

echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

sudo apt-get update
sudo apt-get install -y grafana

log_info "Enabling and starting Grafana service..."
sudo systemctl daemon-reload
sudo systemctl enable grafana-server
sudo systemctl start grafana-server

log_info "Grafana installed and running."