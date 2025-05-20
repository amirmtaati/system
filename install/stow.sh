#!/bin/bash

echo "[*] Stowing dotfiles..."

for dir in awesome zsh scripts; do
    echo " -> $dir"
    stow -v -t "$HOME" "$dir"
done

