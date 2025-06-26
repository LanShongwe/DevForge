#!/bin/bash

# helpers.sh — General helper functions for profile/tool management

list_profiles() {
  echo "----------------------------------------"
  echo "Available Profiles:"
  yq e 'keys | .[]' profiles.yaml
  echo "----------------------------------------"
}

list_tools() {
  echo "----------------------------------------"
  echo "Available Tools:"
  yq e 'keys | .[]' tools.yaml
  echo "----------------------------------------"
}

load_profiles() {
  local profile=$1
  yq e ".$profile[]" profiles.yaml
}

install_tool() {
  local tool=$1
  local script="install_scripts/$(yq e ".${tool}.install_script" tools.yaml)"
  if [[ -f "$script" ]]; then
    log_info "Installing $tool..."
    bash "$script"
  else
    log_error "Install script for $tool not found at $script"
    return 1
  fi
}