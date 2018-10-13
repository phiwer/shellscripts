#!/bin/bash

mkdir -p "$EXTERNAL" 

# Update repositories and update

sudo apt update



# Spotify
sudo apt -qq install -y dirmngr

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A87FF9DF48BF1C90

echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt update

sudo apt -qq install -y libssl1.0.2

sudo apt -qq install -y spotify-client


# I3

sudo apt -qq install -y \
     libxcb-keysyms1-dev \
     libpango1.0-dev \
     libxcb-util0-dev \
     xcb \
     libxcb1-dev \
     libxcb-icccm4-dev \
     libyajl-dev \
     libev-dev \
     libxcb-xkb-dev \
     libxcb-cursor-dev \
     libxkbcommon-dev \
     libxcb-xinerama0-dev \
     libxkbcommon-x11-dev \
     libstartup-notification0-dev \
     libxcb-randr0-dev \
     libxcb-xrm0 \
     libxcb-xrm-dev

cd "$EXTERNAL"
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install


# Add FS-UAE repository
echo "deb http://download.opensuse.org/repositories/home:/FrodeSolheim:/stable/Debian_9.0/ /" | sudo tee /etc/apt/sources.list.d/FrodeSolheim-stable.list
wget -q -O - http://download.opensuse.org/repositories/home:FrodeSolheim:stable/Debian_9.0/Release.key | sudo apt-key add -

# FS-UAE
sudo apt -qq install -y fs-uae fs-uae-launcher fs-uae-arcade


# Chrome

wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

sudo apt update

sudo apt -qq install -y google-chrome-stable

# Emacs
sudo apt -qq install -y emacs

# ZShell
sudo apt -qq install -y zsh

# Hexchat
sudo apt -qq install -y hexchat

# Xfce4 Terminal
sudo apt -qq install -y xfce4-terminal

# Feh
sudo apt -qq install -y feh

# Midnight Commander
sudo apt -qq install -y mc

# Irssi
sudo apt -qq install -y irssi

# Screen
sudo apt -qq install -y screen

# Rofi
sudo apt -qq install -y rofi

# Arandr GUI for xrandr
sudo apt -qq install -y arandr

# Rxvt
sudo apt -qq install -y rxvt-unicode


#sudo add-apt-repository ppa:ubuntu-mozilla-security/ppa

#sudo add-apt-repository ppa:aguignard/ppa

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

sudo apt update

sudo apt upgrade


# Dev
sudo apt -qq install -y dh-autoreconf
sudo apt -qq install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm-dev

# Python
sudo apt -qq install -y python-pip python-dev build-essential
sudo apt -qq install -y python3-pip
sudo pip install --upgrade pip
sudo pip install --upgrade pip3
sudo pip install --upgrade virtualenv

# Numpy & Scipy
sudo pip install numpy scipy

# Scikit learn
sudo pip install -U scikit-learn

# Pywal
sudo pip3 install pywal

# Java
sudo apt -qq install -y openjdk-8-jdk

# Curl
sudo apt -qq install -y curl

# Pidgin
sudo apt -qq install -y pidgin pidgin-sipe

# I2C Tools
sudo apt -qq install -y i2c-tools

# Silver Searcher
sudo apt -qq install -y silversearcher-ag

# Cpu Frequtils
sudo apt -qq install -y cpufrequtils

# Npm
sudo apt -qq install -y nodejs

# Global
sudo apt -qq install -y global

# CCache
sudo apt -qq install -y ccache

# KVM
sudo apt -qq install -y qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils

# CMake
sudo apt -qq install -y cmake

# Ant
sudo apt -qq install -y ant

# Gimp
sudo apt -qq install -y gimp

# Git Review
sudo apt -qq install -y git-review

# cppcheck
sudo apt -qq install -y cppcheck

# meld
sudo apt -qq install -y meld

# Docker
sudo apt -qq remove -y docker docker-engine docker.io

sudo apt -qq install -y \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common

sudo apt -qq install -y docker-ce

sudo apt -qq install -y fonts-powerline

# Edid

sudo apt -qq install -y read-edid

# Iwdef
sudo apt -qq install -y libiw-dev

# Libalsa dev
sudo apt -qq install -y libasound2-dev

# Libpulse dev
sudo apt -qq install -y libpulse-dev

# Libnl
sudo apt -qq install -y libnl-3-dev

# Remove unused packages
#sudo apt autoremove

git clone https://github.com/powerline/fonts.git "$EXTERNAL/powerline-fonts"
cd "$EXTERNAL/powerline-fonts" && ./install.sh && cd 

sudo apt -qq install -y libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev
sudo apt -qq install -y libcairo2-dev
sudo apt -qq install -y cmake cmake-data pkg-config
sudo apt -qq install -y python-xcbgen xcb-proto
sudo apt -qq install -y libxcb-image0-dev
sudo apt -qq install -y libxcb-ewmh-dev libxcb-icccm4-dev
sudo apt -qq install -y libjsoncpp-dev

# TODO: Check if dir already exists. If so, do a git pull.
git clone --branch 3.2 --recursive https://github.com/jaagr/polybar "$EXTERNAL/polybar"
cd "$EXTERNAL/polybar"
# TODO: Remove build if it already exists
mkdir build
cd build
cmake ..
sudo make install

sudo apt-get -qq install -y xkeycaps

sudo apt-get -qq install -y fonts-materialdesignicons-webfont
