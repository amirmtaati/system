#!/bin/bash

# Main installation script for Debian 13 (Trixie) development environment
# This script orchestrates the installation of all components

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[*]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

# Check if running on Debian
if ! command -v lsb_release &> /dev/null || [ "$(lsb_release -si)" != "Debian" ]; then
    print_error "This script is designed for Debian systems only"
    exit 1
fi

# Check Debian version
DEBIAN_VERSION=$(lsb_release -sr)
DEBIAN_CODENAME=$(lsb_release -sc)

print_status "Detected Debian $DEBIAN_VERSION ($DEBIAN_CODENAME)"

if [ "$DEBIAN_CODENAME" != "trixie" ] && [ "${DEBIAN_VERSION%%.*}" -lt 13 ]; then
    print_warning "This script is optimized for Debian 13 (Trixie). Current version: $DEBIAN_VERSION"
    read -p "Do you want to continue? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check if script is run as root
if [ "$EUID" -eq 0 ]; then
    print_error "Please do not run this script as root"
    print_status "Run this script as a regular user: ./install.sh"
    exit 1
fi

# Check if user has sudo privileges
print_status "Checking sudo privileges..."
if ! sudo -v; then
    print_error "This script requires sudo privileges. Please ensure your user is in the sudo group."
    print_status "To add your user to sudo group: su -c 'usermod -aG sudo $USER'"
    exit 1
fi
print_success "Sudo access confirmed"

print_status "Starting full system install for Debian 13 development environment..."

# Create log file
LOG_FILE="$HOME/debian13_install_$(date +%Y%m%d_%H%M%S).log"
exec > >(tee -a "$LOG_FILE")
exec 2>&1

print_status "Installation log will be saved to: $LOG_FILE"

# Function to run script with error handling
run_script() {
    local script_path="$1"
    local script_name=$(basename "$script_path")
    
    if [ -f "$script_path" ]; then
        print_status "Running $script_name..."
        if bash "$script_path"; then
            print_success "$script_name completed successfully"
        else
            print_error "$script_name failed"
            exit 1
        fi
    else
        print_warning "$script_path not found, skipping..."
    fi
}

# Install system dependencies
run_script "install/dependencies.sh"

# Install and configure Zsh
run_script "install/zsh.sh"

# Install V2Ray (commented out by default, uncomment if needed)
# run_script "install/v2ray.sh"

# Setup dotfiles with stow
run_script "install/stow.sh"

print_success "System setup complete!"
print_status "Installation completed at: $(date)"

# Display summary
echo
echo "===================================="
echo "        INSTALLATION SUMMARY"
echo "===================================="
echo "✓ System dependencies installed"
echo "✓ Development tools configured"
echo "✓ Zsh shell setup"
echo "✓ Dotfiles stowed"
echo
echo "NEXT STEPS:"
echo "1. Reboot your system or logout/login to activate all changes"
echo "2. Open a new terminal to use the new shell and tools"
echo "3. Configure your development environment as needed"
echo
echo "Installation log saved to: $LOG_FILE"
echo
print_warning "Some changes require a system restart to take effect"

# Offer to reboot
echo
read -p "Would you like to reboot now? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_status "Rebooting system..."
    sudo reboot
fi