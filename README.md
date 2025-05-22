# System Configuration

My personal system configuration using GNU Stow.

## Quick Setup

```bash
# Install dependencies
sudo apt install awesome rofi alacritty thunar acpi pamixer stow papirus-icon-theme

# Install JetBrains Mono Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache -fv

# Clone and setup
git clone https://github.com/amirmtaati/system.git
cd system
./install/stow.sh
```

## Key Shortcuts

### Apps
- `Win + Enter` → Terminal
- `Win + d` → App launcher
- `Win + b` → Browser
- `Win + e` → Emacs

### Windows
- `Win + h/j/k/l` → Focus
- `Win + Shift + h/j/k/l` → Move
- `Win + Ctrl + h/j/k/l` → Resize

### Workspaces
- `Win + [1-9]` → Switch
- `Win + Shift + [1-9]` → Move window

### Volume
- `Win + =/-` → Volume up/down
- `Win + 0` → Mute

## Components

- **Window Manager**: AwesomeWM
- **Terminal**: Alacritty
- **Application Launcher**: Rofi
- **Text Editor**: Emacs
- **File Manager**: Thunar
- **Shell**: ZSH

## Dependencies

Install the required dependencies:

```bash
# Core components
sudo apt install awesome rofi alacritty thunar acpi pamixer

# Additional tools
sudo apt install stow papirus-icon-theme

# Fonts
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache -fv
```

## Installation

1. Clone this repository:
```bash
git clone https://github.com/amirmtaati/system.git
cd system
```

2. Use GNU Stow to create symlinks:
```bash
./install/stow.sh
```

## Keybindings

### Window Manager (AwesomeWM)

#### Basic Controls
- `Win + Enter` - Open terminal
- `Win + e` - Open Emacs
- `Win + b` - Open web browser
- `Win + Shift + e` - Open file manager
- `Win + c` - Close focused window
- `Win + Space` - Toggle floating mode

#### Workspaces
- `Win + [1-9]` - Switch to workspace 1-9
- `Win + Shift + [1-9]` - Move window to workspace 1-9
- `Win + Left/Right` - Switch to previous/next workspace

#### Window Management
- `Win + h/j/k/l` - Focus window in direction (vim-style)
- `Win + Shift + h/j/k/l` - Move window in direction
- `Win + Ctrl + h/j/k/l` - Resize window

#### Launchers
- `Win + d` - Application launcher (with icons)
- `Win + r` - Run launcher
- `Win + Shift + w` - Window switcher

#### Volume Controls
- Media Keys - Control volume if available
- `Win + =` - Volume up
- `Win + -` - Volume down
- `Win + 0` - Toggle mute

### Additional Features

#### Top Bar Widgets
- Workspace indicators with icons
- Window title
- System tray
- Volume control (clickable)
- Battery status with icons
- Date and time with calendar popup
- Layout indicator

#### Volume Widget
- Left click to toggle mute
- Scroll to adjust volume
- Icons indicate volume level and mute state

#### Battery Widget
- Shows percentage and status
- Different icons for charging/discharging
- Updates every 30 seconds

## Theme

The configuration uses a custom color scheme based on Dracula:
- Background: #282a36
- Foreground: #f8f8f2
- Selection: #44475a
- Accent: #bd93f9
- Alert: #ff5555

## Customization

### AwesomeWM
Main configuration file: `~/.config/awesome/rc.lua`

### Rofi
Configuration file: `~/.config/rofi/config.rasi`

## Troubleshooting

### Battery Widget Not Working
1. Check if ACPI is installed:
```bash
acpi -b
```
2. Ensure your system has a battery:
```bash
ls /sys/class/power_supply/
```

### Volume Controls Not Working
1. Verify pamixer installation:
```bash
pamixer --get-volume-human
```
2. Check PulseAudio status:
```bash
pulseaudio --check
```

## Credits

- Icons: [Nerd Fonts](https://www.nerdfonts.com/)
- Theme inspiration: [Dracula](https://draculatheme.com/)

```bash
git clone https://github.com/yourusername/system.git ~/system
cd ~/system
chmod +x install.sh
./install.sh

