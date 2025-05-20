#!/bin/bash
set -e

echo "[*] Starting full system install..."

bash install/dependencies.sh
bash install/zsh.sh
bash install/v2ray.sh
bash install/stow.sh

echo "[✓] System setup complete."

