#!/bin/bash

# Spring Boot CLI Installer via sdkman

set -e
source utils/logger.sh

log_info "Installing Spring Boot CLI with sdkman..."

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install springboot

log_info "Spring Boot version: $(spring --version)"