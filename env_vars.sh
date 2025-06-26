#!/bin/bash

# env_vars.sh — Setup persistent environment variables

set_env_var() {
  local key=$1
  local value=$2

  if ! grep -q "$key" ~/.bashrc; then
    echo "export $key=\"$value\"" >> ~/.bashrc
    export $key="$value"
    log_info "Set environment variable: $key"
  else
    log_info "$key already set in environment."
  fi
}

apply_env_vars() {
  set_env_var "PATH" "/usr/local/bin:$PATH"
  set_env_var "DEVFORGE_ENV" "true"
}