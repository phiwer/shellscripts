#!/usr/bin/env bash

## TODO: Check if running with normal user. If not, then abort.

set -e

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi


EXTERNAL="/home/$SUDO_USER/sources/external"
APPS="/home/$SUDO_USER/apps/"

mkdir -p "$EXTERNAL" && mkdir -p "$APPS"

# Add keys

## Spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

## Chrome

wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list


## Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo "deb [allow-insecure=yes arch=amd64] https://download.docker.com/linux/debian buster stable" | sudo tee /etc/apt/sources.list.d/docker-stable.list

# Add FS-UAE repository
echo "deb [allow-insecure=yes] http://download.opensuse.org/repositories/home:/FrodeSolheim:/stable/Debian_9.0/ /" | sudo tee /etc/apt/sources.list.d/FrodeSolheim-stable.list
wget -q -O - http://download.opensuse.org/repositories/home:FrodeSolheim:stable/Debian_9.0/Release.key | sudo apt-key add -


# Update repositories and update

apt update --allow-unauthenticated

apt autoremove

## Spotify, i3, Docker

apt -qq remove -y docker docker-engine docker.io

apt -qq install -y \
     software-properties-common \
     curl \
     nvidia-driver \
     dirmngr \
     libssl1.0.2 \
     emacs \
     zsh \
     feh \
     mc \
     rxvt-unicode \
     xsel \
     irssi \
     screen \
     rofi \
     arandr \
     xcb \
     gimp \
     i2c-tools \
     cpufrequtils \
     gnupg2 \
     meld \
     read-edid \
     silversearcher-ag \
     docker-ce \
     fonts-materialdesignicons-webfont \
     compton \
     imagemagick \
     minicom \
     hdparm \
     i3lock \
     spotify-client \
     lightdm \
     xkeycaps \
     firmware-linux \
     libxcb-keysyms1-dev \
     libpango1.0-dev \
     libxcb-util0-dev \
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
     libxcb-xrm-dev \
     libxcb-shape0 \
     libxcb-shape0-dev \
     libpulse-dev \
     libasound2-dev \
     libnl-3-dev \
     libxcb-util0-dev \
     libxcb-composite0-dev \
     libcairo2-dev \
     libiw-dev \
     libxcb-image0-dev \
     libxcb-ewmh-dev \
     python-dev \
     libsecret-1-dev \
     python-xcbgen \
     xcb-proto \
     nfs-common \
     libsecret-1-0 \
     \
     google-chrome-stable \
     ca-certificates \
     \
     autoconf \
     build-essential \
     linux-perf \
     \
     python-pip \
     python-pip \
     python3-pip \
     virtualenv \
     nodejs \
     openjdk-8-jdk \
     ccache \
     cmake \
     ant \
     git-review \
     cppcheck \
     global \
     cmake \
     cmake-data \
     pkg-config \
     wicd \
     nvidia-settings \


# FS-UAE
apt -qq install -y --allow-unauthenticated fs-uae fs-uae-launcher fs-uae-arcade


pip3 install --upgrade setuptools pip
pip3 install numpy scipy
pip3 install -U scikit-learn
pip3 install pywal


# KVM
#sudo apt -qq install -y qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils

# Docker Compose

curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

## i3-gaps
if [ -d "$EXTERNAL/i3-gaps" ]; then
    cd "$EXTERNAL/i3-gaps" && git pull
else
    sudo -u $SUDO_USER git clone https://www.github.com/Airblader/i3 i3-gaps
    cd "$EXTERNAL/i3-gaps"
fi

# compile & install
sudo -u $SUDO_USER autoreconf --force --install
sudo -u $SUDO_USER rm -rf build/
sudo -u $SUDO_USER mkdir -p build
cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
sudo -u $SUDO_USER ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
sudo -u $SUDO_USER make
sudo make install

## Powerline fonts
if [ -d "$EXTERNAL/powerline-fonts" ]; then
    cd "$EXTERNAL/powerline-fonts" && git pull
else
    git clone https://github.com/powerline/fonts.git "$EXTERNAL/powerline-fonts"
    cd "$EXTERNAL/powerline-fonts"
fi

sudo -u $SUDO_USER ./install.sh

## Polybar

POLYBAR_FILE="polybar-3.4.0.tar"
sudo -u $SUDO_USER mkdir -p downloads
sudo -u $SUDO_USER wget "https://github.com/jaagr/polybar/releases/download/3.4.0/$POLYBAR_FILE" -P downloads/
sudo -u $SUDO_USER tar xvf "downloads/$POLYBAR_FILE" -C "$EXTERNAL/"

cd "$EXTERNAL/polybar"

sudo -u $SUDO_USER rm -rf build
sudo -u $SUDO_USER mkdir build
cd build
sudo -u $SUDO_USER cmake ..
make install

rm -rf downloads/$POLYBAR_FILE

exit 0

## Cocos2dx
if [ -d "$EXTERNAL/cocos2d-x" ]; then
    cd "$EXTERNAL/cocos2d-x" && git pull
else
    sudo -u $SUDO_USER git clone https://github.com/cocos2d/cocos2d-x.git "$EXTERNAL/cocos2d-x"
    cd "$EXTERNAL/cocos2d-x"
fi

sudo -u $SUDO_USER python download-deps.py
sudo -u $SUDO_USER git submodule update --init


## Repo

sudo -u $SUDO_USER mkdir /home/$SUDO_USER/bin
sudo -u $SUDO_USER curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
sudo -u $SUDO_USER chmod a+x ~/bin/repo
