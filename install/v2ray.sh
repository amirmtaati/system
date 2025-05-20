#!/bin/bash

echo "[*] Installing V2Ray..."

curl -Ls https://github.com/v2fly/fhs-install-v2ray/raw/master/install-release.sh | sudo bash

echo "[*] Enabling and starting V2Ray..."
sudo systemctl enable v2ray
sudo systemctl start v2ray

echo "[✓] V2Ray installed and running."

