# System

My minimal Linux desktop setup using AwesomeWM and GNU Stow.

## Install

```bash
# Dependencies
sudo apt install awesome rofi alacritty thunar acpi pamixer stow

# Setup
git clone https://github.com/amirmtaati/system.git
cd system
./install/stow.sh
```

## Shortcuts

- `Win + Enter` → Terminal
- `Win + d` → Apps
- `Win + h/j/k/l` → Focus
- `Win + Shift + h/j/k/l` → Move
- `Win + [1-9]` → Workspace
- `Win + =/-` → Volume

## Stack

- AwesomeWM (Window Manager)
- Polybar (Status Bar)
- Rofi (Launcher)
- Alacritty (Terminal)
- Picom (Compositor)

```bash
git clone https://github.com/yourusername/system.git ~/system
cd ~/system
chmod +x install.sh
./install.sh

