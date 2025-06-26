#!/bin/bash

# DevForge: Linux Setup Tool
# Author: Xolani Shongwe

# Load utilities
source utils/helpers.sh
source utils/logger.sh
source utils/resource_check.sh
source detect_os.sh

# Log file setup
log_file="logs/install.log"
mkdir -p logs
touch "$log_file"

clear
echo "🚀 Welcome to DevForge - Dev Environment Installer"

# OS Detection
detect_os || { echo "❌ Unsupported OS. Exiting."; exit 1; }

# Show profiles
echo ""
echo "📦 Available Profiles:"
list_profiles
echo ""

# Profile or custom selection
read -p "📝 Enter profile name (or type 'custom'): " profile

if [[ "$profile" == "custom" ]]; then
    list_tools
    echo ""
    read -p "🔧 Enter tools to install (space-separated): " -a tools
else
    tools=($(load_profile "$profile"))
    if [[ -z "${tools[*]}" ]]; then
        echo "❌ Invalid profile selected."
        exit 1
    fi
fi

# System requirements check
check_system_resources "${tools[@]}"

# Install tools
for tool in "${tools[@]}"; do
    echo "⚙️ Installing $tool..."
    install_tool "$tool" >> "$log_file" 2>&1
    if [[ $? -ne 0 ]]; then
        echo "❌ Installation failed for $tool. See logs/install.log"
    else
        echo "✅ $tool installed successfully."
    fi
done

echo ""
echo "🎉 All installations completed. Check logs/install.log for full details."