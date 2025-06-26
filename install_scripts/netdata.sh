#!/bin/bash

# Netdata Monitoring Agent Installer
# Official: https://learn.netdata.cloud/docs/agent/packaging/installer/

set -e
source utils/logger.sh

log_info "Installing Netdata..."

bash <(curl -Ss https://my-netdata.io/kickstart.sh) --dont-wait --disable-telemetry

log_info "Netdata installed. Access dashboard at http://localhost:19999"