#!/bin/bash

# helpers.sh - Tool/Profile helpers

TOOLS_FILE="tools.yaml"
PROFILES_FILE="profiles.yaml"

# Check for yq
if ! command -v yq &>/dev/null; then
  echo "❌ 'yq' is required but not installed. Run: sudo apt install yq -y"
  exit 1
fi

list_profiles() {
  yq e 'keys | .[]' "$PROFILES_FILE"
}

list_tools() {
  yq e 'keys | .[]' "$TOOLS_FILE"
}

load_profile() {
  local profile="$1"
  yq e ".$profile[]" "$PROFILES_FILE"
}

install_tool() {
  local tool="$1"
  local script
  script=$(yq e ".$tool.install_script" "$TOOLS_FILE")
  if [[ -z "$script" || ! -f "install_scripts/$script" ]]; then
    log_error "Script not found for $tool."
    return 1
  fi
  chmod +x "install_scripts/$script"
  "./install_scripts/$script"
}