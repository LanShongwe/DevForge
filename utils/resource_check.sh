#!/bin/bash

# resource_check.sh — Verifies system RAM and disk space

check_system_resources() {
  local tools=("$@")
  local required_ram=0
  local required_disk=0

  for tool in "${tools[@]}"; do
    tool_ram=$(yq e ".${tool}.ram" tools.yaml | sed 's/MB//g')
    tool_disk=$(yq e ".${tool}.size" tools.yaml | sed 's/MB//g')
    required_ram=$((required_ram + tool_ram))
    required_disk=$((required_disk + tool_disk))
  done

  available_ram=$(free -m | awk '/^Mem:/{print $7}')
  available_disk=$(df -m / | awk 'NR==2 {print $4}')

  echo "Required RAM: ${required_ram}MB | Available: ${available_ram}MB"
  echo "Required Disk: ${required_disk}MB | Available: ${available_disk}MB"

  if (( available_ram < required_ram )); then
    log_error "Insufficient RAM. Required: ${required_ram}MB, Available: ${available_ram}MB"
    exit 1
  fi

  if (( available_disk < required_disk )); then
    log_error "Insufficient Disk Space. Required: ${required_disk}MB, Available: ${available_disk}MB"
    exit 1
  fi

  log_info "System resource check passed."
}