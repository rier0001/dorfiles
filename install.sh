#!/bin/sh

set -oeu pipefail

# Update repos
sudo apt update

# Upgrade system
sudo apt upgrade -y

required_packages="i3 i3lock i3blocks rofi feh picom arandr scrot xfce4-terminal thunar pavucontrol neovim"

additional_packages="timeshift neofetch nala ripgrep btop htop adb fastboot tor torbrowser-launcher wireguard ncdu bat"

cybersec_packages="hcxdumptool hcxtools realtek-rtl88xxau-dkms wifiphisher"

# Install packages
sudo apt install -y \
    required_packages \
    additional_packages \
    cybersec_packages 


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


mkdir -p ~/Development ~/Misc




#cp -R .config ~/                                            
#chmod -R +x ~/.config/i3/scripts
#cd ..
#rm -rf endeavouros-i3wm-setup

# Clean up
sudo apt autoremove -y
sudo apt autocleann
