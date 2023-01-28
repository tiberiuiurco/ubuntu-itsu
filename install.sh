#!/bin/bash

# Check if the Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
  exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# Update packages list and update system
apt update
apt upgrade -y

# Install nala
apt install nala -y

# Making .config and Moving config files and background to Pictures
cd "$builddir" || exit
mkdir -p "/home/$username/.config"
mkdir -p "/home/$username/.fonts"
mkdir -p "/home/$username/Pictures"
mkdir -p /usr/share/sddm/themes
#cp .Xresources "/home/$username"
#cp .Xnord "/home/$username"
#cp -R dotconfig/* "/home/$username/.config/"
#cp bg.jpg "/home/$username/Pictures/"
chown -R "$username:$username" "/home/$username"

# Installing Essential Programs
nala install snapd rofi nitrogen flameshot volumeicon-alsa pavucontrol -y

# Installing Snap Programs
snap install nvim --classic
snap install alacritty --classic

# Installing DWM
nala install build-essential libx11-dev libxinerama-dev sharutils libxft-dev -y # DWM build dependencies
nala install gdm3 -y # GDM3 Display Manager
cp dwm.desktop /usr/share/xsessions/dwm.desktop
git clone https://github.com/tiberiuiurco/dwm.git
cd dwm || exit
make install
cd "$builddir" || exit
git clone https://github.com/tiberiuiurco/dwmblocks.git
cd dwmblocks || exit
make install
cd "$builddir" || exit
git clone https://git.suckless.org/dmenu
cd dmenu || exit
make install
cd "$builddir" || exit
