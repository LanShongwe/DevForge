#!/bin/bash

# Ansible Installer (Ubuntu)
# https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-the-control-node

set -e
source utils/logger.sh

log_info "Installing Ansible..."

sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible

log_info "Ansible installed successfully."
ansible --version