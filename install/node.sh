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

# Install nvm (Node Version Manager)
print_status "Installing Node Version Manager (nvm)..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install latest LTS version of Node.js
print_status "Installing latest LTS version of Node.js..."
nvm install --lts
nvm use --lts

# Set the LTS version as default
nvm alias default 'lts/*'

# Update npm to latest version
print_status "Updating npm to latest version..."
npm install -g npm@latest

# Display versions
print_success "Node.js installation completed!"
echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"

# Add some useful global npm packages
print_status "Installing useful global npm packages..."
npm install -g yarn pnpm typescript ts-node 