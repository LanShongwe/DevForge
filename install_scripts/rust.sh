#!/bin/bash

# Rust Installer via rustup

set -e
source utils/logger.sh

log_info "Installing Rust toolchain..."

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source "$HOME/.cargo/env"

log_info "Rust version: $(rustc --version)"