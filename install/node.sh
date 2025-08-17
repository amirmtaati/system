#!/bin/bash

# Node.js Installation Script for Debian 13
# Installs latest NVM and Node.js LTS

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

# Get latest NVM version from GitHub API
print_status "Getting latest NVM version..."
NVM_VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
if [ -z "$NVM_VERSION" ]; then
    print_warning "Could not fetch latest NVM version, using fallback"
    NVM_VERSION="v0.39.7"
fi
print_status "Installing NVM version: $NVM_VERSION"

# Install nvm (Node Version Manager)
print_status "Installing Node Version Manager (nvm)..."
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash

# Load nvm for current session
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Verify nvm installation
if ! command -v nvm &> /dev/null; then
    print_error "NVM installation failed"
    exit 1
fi

# Install latest LTS version of Node.js
print_status "Installing latest LTS version of Node.js..."
nvm install --lts
nvm use --lts

# Set the LTS version as default
nvm alias default 'lts/*'

# Update npm to latest version
print_status "Updating npm to latest version..."
npm install -g npm@latest

# Install Yarn package manager
print_status "Installing Yarn package manager..."
npm install -g yarn

# Install pnpm package manager
print_status "Installing pnpm package manager..."
npm install -g pnpm

# Install useful global npm packages
print_status "Installing useful global npm packages..."
npm install -g \
    typescript \
    ts-node \
    @types/node \
    eslint \
    prettier \
    nodemon \
    pm2 \
    serve \
    http-server \
    live-server \
    create-react-app \
    create-next-app \
    @vue/cli \
    @angular/cli \
    vercel \
    netlify-cli

# Display versions
print_success "Node.js installation completed!"
echo "NVM version: $(nvm --version)"
echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"
echo "Yarn version: $(yarn --version)"
echo "pnpm version: $(pnpm --version)"

print_success "Node.js development environment is ready!"
print_status "Available Node.js versions: $(nvm list)"
print_warning "Remember to restart your terminal or run 'source ~/.bashrc' to use nvm commands"