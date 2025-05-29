#!/bin/bash

echo "[*] Stowing dotfiles..."

for dir in awesome zsh scripts polybar dunst rofi picom kitty; do
    echo " -> $dir"
    stow -v -t "$HOME" "$dir"
done

