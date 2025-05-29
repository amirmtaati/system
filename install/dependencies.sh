#!/bin/bash

# Enhanced Debian Developer Dependencies Installation Script
# This script installs essential development tools and software

set -e  # Exit on any error

echo "[*] Starting comprehensive developer environment setup..."

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

# Update system
print_status "Updating system packages..."
sudo apt update && sudo apt upgrade -y
print_success "System updated"

# Enable backports for latest software versions
print_status "Enabling Debian backports..."
echo "deb http://deb.debian.org/debian $(lsb_release -sc)-backports main" | sudo tee /etc/apt/sources.list.d/backports.list
sudo apt update
print_success "Backports enabled"

# Basic system tools
print_status "Installing basic system tools..."
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    software-properties-common \
    build-essential \
    git \
    curl \
    wget \
    stow \
    htop \
    btop \
    neofetch \
    tree \
    unzip \
    zip \
    p7zip-full \
    rsync \
    ssh \
    tmux \
    screen \
    vim \
    nano
print_success "Basic tools installed"

# Development tools
print_status "Installing development tools..."
sudo apt install -y \
    gcc \
    g++ \
    make \
    cmake \
    ninja-build \
    pkg-config \
    autoconf \
    automake \
    libtool \
    gdb \
    valgrind \
    clang \
    lldb \
    python3 \
    python3-pip \
    python3-venv \
    default-jdk \
    maven \
    gradle \
    rustc \
    cargo \
    golang-go \
    lua5.4 \
    luarocks 

print_success "Development tools installed"

# Install Node.js using nvm
print_status "Setting up Node.js environment..."
bash "$(dirname "$0")/node.sh"
print_success "Node.js environment setup completed"

# Version control and collaboration
print_status "Installing version control tools..."
sudo apt install -y \
    git \
    git-lfs \
    gitk \
    git-gui \
    tig \
    gh
print_success "Version control tools installed"

# Terminal and shell enhancements
print_status "Installing terminal enhancements..."
sudo apt install -y \
    zsh \
    fzf \
    ripgrep \
    fd-find \
    bat \
    exa \
    zoxide \
    shellcheck \
    shfmt
print_success "Terminal enhancements installed"

# Text editors and IDEs
print_status "Installing text editors..."
# Install latest Emacs from backports
sudo apt install -y -t $(lsb_release -sc)-backports emacs
print_success "Text editors installed"

# LaTeX and document processing
print_status "Installing LaTeX and document tools..."
sudo apt install -y \
    texlive-full \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-lang-european \
    texlive-lang-other \
    texlive-bibtex-extra \
    biber \
    pandoc 
print_success "LaTeX and document tools installed"

# Media and graphics tools
print_status "Installing media and graphics tools..."
sudo apt install -y \
    mpv \
    vlc \
    gimp \
    imagemagick \
    ffmpeg \
    audacity \

# Fonts and icons
print_status "Installing fonts and icons..."
sudo apt install -y \
    fonts-firacode \
    fonts-hack \
    fonts-inconsolata \
    fonts-jetbrains-mono \
    fonts-liberation \
    fonts-noto \
    fonts-noto-color-emoji \
    fonts-open-sans \
    fonts-roboto \
    fonts-font-awesome \
    papirus-icon-theme \

print_success "Fonts and icons installed"

# PDF and document viewers
print_status "Installing document viewers..."
sudo apt install -y \
    zathura \
    zathura-pdf-poppler \
    zathura-ps \
    zathura-djvu \
    evince \
    okular \
    xpdf

print_success "Document viewers installed"

print_status "Installing window manager..."
sudo apt install -y \
    awesome \
    picom \
    kitty \
    rofi \
    dunst \
    feh \
    papirus-icon-theme arc-theme \


# Final cleanup
print_status "Cleaning up..."
sudo apt autoremove -y
sudo apt autoclean
print_success "Cleanup completed"

# Configure network and V2Ray
print_status "Configuring network and V2Ray..."
bash "$(dirname "$0")/network-config.sh"
print_success "Network configuration completed"

print_success "All installations completed successfully!"
print_warning "Please reboot your system or log out and back in to ensure all changes take effect."
print_status "Some applications may require additional configuration."
