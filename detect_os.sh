#!/bin/bash

# detect_os.sh — Detect supported Linux distro

detect_os() {
  os=$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"')
  version=$(awk -F= '/^VERSION_ID=/{print $2}' /etc/os-release | tr -d '"')

  if [[ "$os" != "ubuntu" ]]; then
    log_error "Unsupported OS: $os. DevForge currently supports Ubuntu."
    exit 1
  fi

  log_info "Detected OS: $os $version"
}