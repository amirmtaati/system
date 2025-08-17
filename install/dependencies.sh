#!/bin/bash

# Enhanced Debian 13 (Trixie) Developer Dependencies Installation Script
# This script installs essential development tools and software

set -e  # Exit on any error

echo "[*] Starting comprehensive developer environment setup for Debian 13..."

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

# Clean up old backports from Debian 12 (Bookworm)
print_status "Cleaning up old Debian 12 backports..."
sudo rm -f /etc/apt/sources.list.d/backports.list
sudo rm -f /etc/apt/sources.list.d/*bookworm*
print_success "Old backports cleaned up"

# Update system
print_status "Updating system packages..."
sudo apt update && sudo apt upgrade -y
print_success "System updated"

# Add Debian 13 (Trixie) backports for bleeding edge packages
print_status "Adding Debian 13 (Trixie) backports..."
echo "deb http://deb.debian.org/debian trixie-backports main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list.d/trixie-backports.list
sudo apt update
print_success "Trixie backports enabled"

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
    fastfetch \
    tree \
    unzip \
    zip \
    p7zip-full \
    rsync \
    ssh \
    tmux \
    screen \
    vim \
    nano \
    micro
print_success "Basic tools installed"

# Development tools
print_status "Installing development tools..."
sudo apt install -y \
    gcc \
    g++ \
    make \
    cmake \
    ninja-build \
    meson \
    pkg-config \
    autoconf \
    automake \
    libtool \
    gdb \
    valgrind \
    clang \
    clang-format \
    clang-tidy \
    lldb \
    python3 \
    python3-pip \
    python3-venv \
    python3-dev \
    default-jdk \
    openjdk-21-jdk \
    maven \
    gradle \
    rustc \
    cargo \
    golang-go \
    lua5.4 \
    luarocks \
    julia

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
    gh \
    lazygit
print_success "Version control tools installed"

# Terminal and shell enhancements
print_status "Installing terminal enhancements..."
sudo apt install -y \
    zsh \
    fish \
    fzf \
    ripgrep \
    fd-find \
    bat \
    eza \
    zoxide \
    shellcheck \
    shfmt \
    starship \
    tldr \
    duf \
    dust \
    procs \
    bandwhich \
    bottom \
    hyperfine \
    delta \
    lsd
print_success "Terminal enhancements installed"

# Try to install latest Neovim from backports, fallback to main
print_status "Installing text editors..."
if sudo apt install -y -t trixie-backports neovim 2>/dev/null; then
    print_success "Neovim installed from backports"
else
    print_warning "Backports Neovim not available, installing from main repository"
    sudo apt install -y neovim
fi

# Install Emacs (should be latest in Trixie)
sudo apt install -y emacs
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
    pandoc \
    typst
print_success "LaTeX and document tools installed"

# Media and graphics tools
print_status "Installing media and graphics tools..."
sudo apt install -y \
    mpv \
    vlc \
    gimp \
    inkscape \
    imagemagick \
    ffmpeg \
    obs-studio \
    audacity \
    blender

print_success "Media and graphics tools installed"

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
    fonts-cascadia-code \
    fonts-ubuntu \
    papirus-icon-theme \
    arc-theme \
    adwaita-icon-theme-full

print_success "Fonts and icons installed"

# PDF and document viewers
print_status "Installing document viewers..."
sudo apt install -y \
    zathura \
    zathura-pdf-poppler \
    zathura-ps \
    zathura-djvu \
    zathura-cb \
    evince \
    okular \
    xpdf \
    qpdfview

print_success "Document viewers installed"

# Window manager and desktop environment tools
print_status "Installing window manager and desktop tools..."
sudo apt install -y \
    awesome \
    i3-wm \
    i3status \
    i3lock \
    picom \
    kitty \
    alacritty \
    wezterm \
    rofi \
    wofi \
    dunst \
    mako-notifier \
    feh \
    nitrogen \
    polybar \
    waybar \
    papirus-icon-theme \
    arc-theme \
    materia-gtk-theme

print_success "Window manager and desktop tools installed"

# Container and virtualization tools
print_status "Installing container and virtualization tools..."
# Add Docker repository for latest version
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian trixie stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin \
    podman \
    qemu-system \
    libvirt-daemon-system \
    virt-manager

# Add user to docker group
sudo usermod -aG docker "$USER"
print_success "Container and virtualization tools installed"

# Network tools
print_status "Installing network tools..."
sudo apt install -y \
    nmap \
    netcat-openbsd \
    tcpdump \
    wireshark \
    iperf3 \
    mtr \
    dnsutils \
    whois \
    curl \
    wget \
    httpie \
    aria2

print_success "Network tools installed"

# System monitoring and performance tools
print_status "Installing system monitoring tools..."
sudo apt install -y \
    htop \
    btop \
    iotop \
    nethogs \
    iftop \
    glances \
    ncdu \
    stress-ng \
    sysbench \
    perf-tools-unstable

print_success "System monitoring tools installed"

# Database tools
print_status "Installing database tools..."
sudo apt install -y \
    sqlite3 \
    postgresql-client \
    mysql-client \
    redis-tools \
    mongodb-clients

print_success "Database tools installed"

# Security tools
print_status "Installing security tools..."
sudo apt install -y \
    gpg \
    pass \
    keepassxc \
    firejail \
    apparmor \
    fail2ban \
    rkhunter \
    chkrootkit

print_success "Security tools installed"

# Archive and compression tools
print_status "Installing archive and compression tools..."
sudo apt install -y \
    zip \
    unzip \
    p7zip-full \
    rar \
    unrar \
    xz-utils \
    zstd \
    lz4 \
    brotli

print_success "Archive and compression tools installed"

# Communication tools
print_status "Installing communication tools..."
sudo apt install -y \
    thunderbird \
    signal-desktop \
    telegram-desktop \
    discord \
    element-desktop

print_success "Communication tools installed"

# Web browsers
print_status "Installing web browsers..."
# Add Google Chrome repository
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list

# Add Microsoft Edge repository
curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-edge-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft-edge-keyring.gpg] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list

sudo apt update
sudo apt install -y \
    firefox-esr \
    chromium \
    google-chrome-stable \
    microsoft-edge-stable

print_success "Web browsers installed"

# Final cleanup
print_status "Cleaning up..."
sudo apt autoremove -y
sudo apt autoclean
print_success "Cleanup completed"

# Configure network and V2Ray
print_status "Configuring network and V2Ray..."
if [ -f "$(dirname "$0")/network-config.sh" ]; then
    bash "$(dirname "$0")/network-config.sh"
    print_success "Network configuration completed"
else
    print_warning "Network configuration script not found, skipping..."
fi

print_success "All installations completed successfully!"
print_warning "Please reboot your system or log out and back in to ensure all changes take effect."
print_status "Docker group membership will be active after logout/login."
print_status "Some applications may require additional configuration."