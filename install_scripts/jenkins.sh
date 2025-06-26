#!/bin/bash

# Jenkins Installer (Ubuntu)
# https://www.jenkins.io/doc/book/installing/linux/#debianubuntu

set -e
source utils/logger.sh

log_info "Installing Jenkins..."

sudo apt update
sudo apt install -y openjdk-11-jdk

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update
sudo apt install -y jenkins

log_info "Enabling and starting Jenkins service..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

log_info "Jenkins installed and running."