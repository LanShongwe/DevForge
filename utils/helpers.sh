#!/bin/bash

# helpers.sh - Tool/Profile helpers

TOOLS_FILE="tools.yaml"
PROFILES_FILE="profiles.yaml"

# Ensure yq is installed
ensure_yq_installed() {
  if ! command -v yq &>/dev/null; then
    echo "🔧 'yq' not found. Installing it for you..."

    YQ_BINARY_URL="https://github.com/mikefarah/yq/releases/latest/download/yq_linux_amd64"
    YQ_DEST="/usr/local/bin/yq"

    sudo curl -L "$YQ_BINARY_URL" -o "$YQ_DEST"
    sudo chmod +x "$YQ_DEST"

    if ! command -v yq &>/dev/null; then
      echo "❌ 'yq' installation failed. Please install manually: https://github.com/mikefarah/yq"
      exit 1
    else
      echo "✅ 'yq' installed successfully."
    fi
  fi
}

# Call check before any yq command is used
ensure_yq_installed

# List all profile names
list_profiles() {
  echo ""
  echo "----------------------------------------"
  echo "📁 Available DevForge Profiles:"
  echo "----------------------------------------"
  yq e 'keys | .[]' "$PROFILES_FILE"
}

# List all available tools
list_tools() {
  echo ""
  echo "----------------------------------------"
  echo "🧰 Available Tools:"
  echo "----------------------------------------"
  yq e 'keys | .[]' "$TOOLS_FILE"
}

# Load a profile and return its tools
load_profile() {
  local profile="$1"
  yq e ".$profile[]" "$PROFILES_FILE"
}

# Install a tool from the YAML definition
install_tool() {
  local tool="$1"
  local script
  script=$(yq e ".$tool.install_script" "$TOOLS_FILE")

  if [[ -z "$script" || ! -f "install_scripts/$script" ]]; then
    log_error "Script not found for '$tool'. Expected: install_scripts/$script"
    return 1
  fi

  chmod +x "install_scripts/$script"
  "./install_scripts/$script"
}
