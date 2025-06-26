#!/bin/bash

# logger.sh — Provides logging functions with levels

log_info() {
  echo -e "[INFO] $1" | tee -a logs/install.log
}

log_warn() {
  echo -e "[WARN] $1" | tee -a logs/install.log
}

log_error() {
  echo -e "[ERROR] $1" | tee -a logs/install.log >&2
}