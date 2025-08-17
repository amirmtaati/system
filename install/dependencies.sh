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

# Function to safely install packages
safe_install() {
    local packages=("$@")
    local failed_packages=()
    
    for package in "${packages[@]}"; do
        if sudo apt install -y "$package" 2>/dev/null; then
            print_success "$package installed"
        else
            print_warning "$package installation failed, skipping"
            failed_packages+=("$package")
        fi
    done
    
    if [ ${#failed_packages[@]} -gt 0 ]; then
        print_warning "Failed to install: ${failed_packages[*]}"
    fi
}

# Check if running with correct privileges
if [ "$EUID" -eq 0 ]; then
    print_error "Please do not run this script as root"
    exit 1
fi

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
if [ "$(lsb_release -sc)" = "trixie" ]; then
    echo "deb http://deb.debian.org/debian trixie-backports main contrib non-free non-free-firmware" | sudo tee /etc/apt/sources.list.d/trixie-backports.list
    sudo apt update
    print_success "Trixie backports enabled"
else
    print_warning "Not running Trixie, skipping backports setup"
fi

# Basic system tools
print_status "Installing basic system tools..."
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    gnupg \
    lsb-release \
    build-essential \
    git \
    curl \
    wget \
    stow \
    htop \
    btop \
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

# Install optional packages that might not be available
for pkg in software-properties-common neofetch fastfetch micro; do
    if sudo apt install -y "$pkg" 2>/dev/null; then
        print_success "$pkg installed"
    else
        print_warning "$pkg not available, skipping"
    fi
done

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
    shellcheck \
    shfmt

# Install optional terminal tools that might not be available
for pkg in eza zoxide starship tldr duf dust procs bandwhich bottom hyperfine delta lsd; do
    if sudo apt install -y "$pkg" 2>/dev/null; then
        print_success "$pkg installed"
    else
        print_warning "$pkg not available in repositories, you can install it later via cargo/snap"
    fi
done

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
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-lang-european \
    pandoc

# Install optional LaTeX packages
for pkg in texlive-full texlive-bibtex-extra biber typst; do
    if sudo apt install -y "$pkg" 2>/dev/null; then
        print_success "$pkg installed"
    else
        print_warning "$pkg not available, continuing with basic LaTeX installation"
    fi
done

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
    audacity

# Try to install optional packages that might not be available
for pkg in obs-studio blender; do
    if sudo apt install -y "$pkg" 2>/dev/null; then
        print_success "$pkg installed"
    else
        print_warning "$pkg not available, skipping"
    fi
done

print_success "Media and graphics tools installed"

# Fonts and icons
print_status "Installing fonts and icons..."
sudo apt install -y \
    fonts-liberation \
    fonts-noto \
    fonts-noto-color-emoji \
    fonts-open-sans \
    fonts-roboto \
    fonts-ubuntu

# Install optional fonts that might not be available
for pkg in fonts-firacode fonts-hack fonts-inconsolata fonts-jetbrains-mono fonts-font-awesome fonts-cascadia-code papirus-icon-theme arc-theme adwaita-icon-theme-full; do
    if sudo apt install -y "$pkg" 2>/dev/null; then
        print_success "$pkg installed"
    else
        print_warning "$pkg not available, skipping"
    fi
done

print_success "Core fonts and icons installed"

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
    rofi \
    dunst \
    feh

# Install optional desktop tools
for pkg in alacritty wezterm wofi mako-notifier nitrogen polybar waybar papirus-icon-theme arc-theme materia-gtk-theme; do
    if sudo apt install -y "$pkg" 2>/dev/null; then
        print_success "$pkg installed"
    else
        print_warning "$pkg not available, skipping"
    fi
done

print_success "Window manager and desktop tools installed"

# Container and virtualization tools
print_status "Installing container and virtualization tools..."

# Try to add Docker repository
print_status "Attempting to add Docker repository..."
if curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg 2>/dev/null; then
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian trixie stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    if sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 2>/dev/null; then
        print_success "Docker installed from official repository"
        # Add user to docker group
        sudo usermod -aG docker "$USER"
        print_success "User added to docker group"
    else
        print_warning "Docker installation from official repo failed, trying from main repository"
        sudo apt install -y docker.io docker-compose podman 2>/dev/null || print_warning "Docker installation failed"
    fi
else
    print_warning "Could not add Docker repository, installing from main repository"
    sudo apt install -y docker.io docker-compose podman 2>/dev/null || print_warning "Docker installation failed"
fi

# Install other virtualization tools
sudo apt install -y qemu-system libvirt-daemon-system 2>/dev/null || print_warning "QEMU/libvirt installation failed"

# Try to install virt-manager (might not be available)
if sudo apt install -y virt-manager 2>/dev/null; then
    print_success "virt-manager installed"
else
    print_warning "virt-manager not available, skipping"
fi

print_success "Container and virtualization tools setup completed"

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
    ncdu

# Install optional monitoring tools
for pkg in stress-ng sysbench perf-tools-unstable; do
    if sudo apt install -y "$pkg" 2>/dev/null; then
        print_success "$pkg installed"
    else
        print_warning "$pkg not available, skipping"
    fi
done

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
    keepassxc \
    firejail \
    apparmor

# Install optional security tools
for pkg in pass fail2ban rkhunter chkrootkit; do
    if sudo apt install -y "$pkg" 2>/dev/null; then
        print_success "$pkg installed"
    else
        print_warning "$pkg not available, skipping"
    fi
done

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
sudo apt install -y thunderbird

# Try to install optional packages that might not be available in main repos
for pkg in signal-desktop telegram-desktop discord element-desktop; do
    if sudo apt install -y "$pkg" 2>/dev/null; then
        print_success "$pkg installed"
    else
        print_warning "$pkg not available in main repositories, skipping"
    fi
done

print_success "Core communication tools installed"

# Web browsers
print_status "Installing web browsers..."
# Install Firefox ESR and Chromium from main repos
sudo apt install -y firefox-esr chromium

# Try to add and install Chrome
print_status "Attempting to add Google Chrome repository..."
if wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo gpg --dearmor -o /usr/share/keyrings/google-chrome-keyring.gpg 2>/dev/null; then
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/google-chrome-keyring.gpg] http://dl.google.com/linux/chrome/deb/ stable main" | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null
    if sudo apt update && sudo apt install -y google-chrome-stable 2>/dev/null; then
        print_success "Google Chrome installed"
    else
        print_warning "Google Chrome installation failed, continuing without it"
    fi
else
    print_warning "Could not add Google Chrome repository, skipping"
fi

# Try to add and install Microsoft Edge
print_status "Attempting to add Microsoft Edge repository..."
if curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | sudo gpg --dearmor -o /usr/share/keyrings/microsoft-edge-keyring.gpg 2>/dev/null; then
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/microsoft-edge-keyring.gpg] https://packages.microsoft.com/repos/edge stable main" | sudo tee /etc/apt/sources.list.d/microsoft-edge.list > /dev/null
    if sudo apt update && sudo apt install -y microsoft-edge-stable 2>/dev/null; then
        print_success "Microsoft Edge installed"
    else
        print_warning "Microsoft Edge installation failed, continuing without it"
    fi
else
    print_warning "Could not add Microsoft Edge repository, skipping"
fi

print_success "Core web browsers installed"

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