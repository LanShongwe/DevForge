#!/bin/bash

# Prometheus Installer (Ubuntu)
# Based on official docs: https://prometheus.io/docs/prometheus/latest/installation/

set -e
source utils/logger.sh

PROM_VERSION="2.47.0"   # update to latest stable if needed
PROM_USER="prometheus"
PROM_DIR="/usr/local/bin"
PROM_CONFIG_DIR="/etc/prometheus"
PROM_DATA_DIR="/var/lib/prometheus"

log_info "Installing Prometheus version $PROM_VERSION..."

# Create Prometheus user
if ! id -u $PROM_USER >/dev/null 2>&1; then
    sudo useradd --no-create-home --shell /bin/false $PROM_USER
fi

# Download and extract Prometheus
cd /tmp
curl -LO https://github.com/prometheus/prometheus/releases/download/v$PROM_VERSION/prometheus-$PROM_VERSION.linux-amd64.tar.gz
tar xvf prometheus-$PROM_VERSION.linux-amd64.tar.gz

sudo mv prometheus-$PROM_VERSION.linux-amd64/prometheus $PROM_DIR/
sudo mv prometheus-$PROM_VERSION.linux-amd64/promtool $PROM_DIR/

# Move consoles and console_libraries
sudo mkdir -p $PROM_CONFIG_DIR
sudo mv prometheus-$PROM_VERSION.linux-amd64/consoles $PROM_CONFIG_DIR/
sudo mv prometheus-$PROM_VERSION.linux-amd64/console_libraries $PROM_CONFIG_DIR/

# Set permissions
sudo chown -R $PROM_USER:$PROM_USER $PROM_CONFIG_DIR
sudo mkdir -p $PROM_DATA_DIR
sudo chown $PROM_USER:$PROM_USER $PROM_DATA_DIR

# Clean up
rm -rf prometheus-$PROM_VERSION.linux-amd64*
log_info "Prometheus binaries installed and configured."

# Create systemd service file
sudo tee /etc/systemd/system/prometheus.service > /dev/null <<EOF
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
User=$PROM_USER
Group=$PROM_USER
Type=simple
ExecStart=$PROM_DIR/prometheus \\
  --config.file=$PROM_CONFIG_DIR/prometheus.yml \\
  --storage.tsdb.path=$PROM_DATA_DIR \\
  --web.console.templates=$PROM_CONFIG_DIR/consoles \\
  --web.console.libraries=$PROM_CONFIG_DIR/console_libraries

Restart=always

[Install]
WantedBy=multi-user.target
EOF

log_info "Starting Prometheus service..."
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

log_info "Prometheus installed and running."