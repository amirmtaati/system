#!/bin/bash

echo "[*] Updating system and installing required packages..."

sudo apt update
sudo apt install -y git curl stow wget

