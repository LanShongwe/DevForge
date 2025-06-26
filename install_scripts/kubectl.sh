#!/bin/bash

# kubectl Installer (Linux)
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/

set -e
source utils/logger.sh

log_info "Installing kubectl..."

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

log_info "kubectl installed successfully."
kubectl version --client