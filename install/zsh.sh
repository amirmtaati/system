#!/bin/bash

echo "[*] Installing Zsh..."

sudo apt install -y zsh

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "[*] Changing default shell to zsh for user $USER"
    chsh -s "$(which zsh)"
fi

# Optional: install Oh My Zsh
read -p "[?] Install Oh My Zsh? (y/n): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
    echo "[*] Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

