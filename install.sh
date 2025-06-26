#!/bin/bash

# DevForge: Linux Setup Tool (Enterprise UX)
# Author: Xolani Shongwe

source utils/helpers.sh
source utils/logger.sh
source utils/resource_check.sh
source detect_os.sh

# Create logs folder if not exists
mkdir -p logs
log_file="logs/install.log"
touch "$log_file"

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[1;34m'; NC='\033[0m'

# ASCII banner (uses figlet if installed)
clear
if command -v figlet &>/dev/null; then
  figlet "DevForge"
else
  echo -e "${BLUE}"
  echo "╔════════════════════════════════════════╗"
  echo "║           🚀 DevForge Setup           ║"
  echo "╚════════════════════════════════════════╝"
  echo -e "${NC}"
fi

# OS Detection
detect_os || { echo -e "${RED}❌ Unsupported OS. Exiting.${NC}"; exit 1; }

echo -e "${BLUE}📦 Available Profiles${NC}"
echo "------------------------------------------"
list_profiles
echo "------------------------------------------"

read -p "📝 ${YELLOW}Enter profile name (or type 'custom'): ${NC}" profile

if [[ "$profile" == "custom" ]]; then
    echo -e "\n🔧 ${BLUE}Available Tools${NC}"
    echo "------------------------------------------"
    list_tools
    echo "------------------------------------------"
    read -p "🔧 Enter tools to install (space-separated): " -a tools
else
    tools=($(load_profile "$profile"))
    if [[ -z "${tools[*]}" ]]; then
        echo -e "${RED}❌ Invalid profile selected. Exiting.${NC}"
        exit 1
    fi
fi

echo -e "\n🔍 ${BLUE}Checking system requirements...${NC}"
check_system_resources "${tools[@]}" || {
    echo -e "${RED}🚫 System does not meet the requirements.${NC}"
    exit 1
}

echo -e "\n⚙️  ${YELLOW}Starting tool installation...${NC}"
echo "------------------------------------------"

for tool in "${tools[@]}"; do
    echo -e "🔧 Installing ${BLUE}$tool${NC}..."
    install_tool "$tool" >> "$log_file" 2>&1
    if [[ $? -ne 0 ]]; then
        echo -e "❌ ${RED}$tool installation failed.${NC} Check logs/install.log"
    else
        echo -e "✅ ${GREEN}$tool installed successfully.${NC}"
    fi
done

echo -e "\n🎉 ${GREEN}All installations completed.${NC}"
echo "📝 Full logs available at ${YELLOW}logs/install.log${NC}"