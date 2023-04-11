#!/bin/sh

set -e

# Check if the script is run with sudo
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run with sudo. Try: sudo $0" >&2
    exit 1
fi

# Update repos
sudo apt update

# Upgrade system
sudo apt upgrade -y

# Packages required for setting up environment
required_packages="i3 rofi nitrogen picom arandr scrot thunar pavucontrol neovim alsa-utils \
                arandr betterlockscreen brightnessctl lightdm lxappearance neofetch \
                network-manager network-manager-gnome numlockx pavucontrol polybar pulseaudio \
                python3-i3ipc qt5ct ranger suckless-tools xfce4-power-manager xorg slick-greeter kitty"

# Additional packages
additional_packages="timeshift neofetch nala ripgrep btop htop adb fastboot tor torbrowser-launcher wireguard ncdu bat"

# Cybersecurity related packages
cybersec_packages="hcxdumptool hcxtools realtek-rtl88xxau-dkms wifiphisher"

# Install packages
sudo apt install -y $required_packages $additional_packages $cybersec_packages

# Updating tldr database
tldr -u

# Vscode
wget -O /tmp/vscode.deb https://update.code.visualstudio.com/latest/linux-deb-x64/stable
sudo apt install /tmp/vscode.deb
rm /tmp/vscode.deb

# Obsidian
RELEASES_URL="https://api.github.com/repos/obsidianmd/obsidian-releases/releases/latest"
DOWNLOAD_URL="$(wget -q "${RELEASES_URL}" -O - | jq -r '.assets[] | select(.name | endswith("_amd64.deb")) | .browser_download_url')"

wget "${DOWNLOAD_URL}" -O /tmp/obsidian.deb
sudo apt install /tmp/obsidian.deb
rm /tmp/obsidian.deb

# Nvim
wget -O /tmp/nvim-linux64.deb https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo apt install /tmp/nvim-linux64.deb
rm /tmp/nvim-linux64.deb
git clone https://github.com/nvim-lua/kickstart.nvim.git ~/.config/nvim

# Create dirs
mkdir -p -v ~/Development ~/Misc

cp -R wallpapers ~/Pictures
sudo cp wallpapers/login.jpg /usr/share/backgrounds/xfce/
rm -R wallpapers

sudo cp -R lightdm /etc/lightdm
rm -R lightdm

cp -R * ~/.config
rm ~/.config/README.md ~/.config/install.sh

# Clean up
sudo apt autoremove -y
sudo apt autoclean