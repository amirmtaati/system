#!/bin/bash

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

# Setup V2Ray service
print_status "Setting up V2Ray systemd service..."
sudo cp "$(dirname "$0")/../v2ray/v2ray.service" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable v2ray.service
sudo systemctl start v2ray.service
print_success "V2Ray service configured and started"

