#!/usr/bin/env bash

## TODO: Add non-free and contrib to sources.list

set -e

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

apt -qq install -y curl wget

EXTERNAL="/home/$SUDO_USER/sources/external"
APPS="/home/$SUDO_USER/apps/"
BIN="/home/$SUDO_USER/bin/"

sudo -u $SUDO_USER mkdir -p "$EXTERNAL"
sudo -u $SUDO_USER mkdir -p "$APPS"
sudo -u $SUDO_USER mkdir -p "$BIN"

# Add keys

## Multimedia
#wget http://www.deb-multimedia.org/pool/main/d/deb-multimedia-keyring/deb-multimedia-keyring_2016.8.1_all.deb && sudo dpkg -i deb-multimedia-keyring_2016.8.1_all.deb
#apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E

## Spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D1742AD60D811D58
echo "deb [allow-insecure=yes trusted=yes arch=amd64] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

## Chrome
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

## Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
echo "deb [allow-insecure=yes trusted=yes arch=amd64] https://download.docker.com/linux/debian buster stable" | sudo tee /etc/apt/sources.list.d/docker-stable.list

# Add FS-UAE repository1
wget -q -O - https://download.opensuse.org/repositories/home:FrodeSolheim:stable/Debian_10/Release.key | sudo apt-key add -
echo "deb [allow-insecure=yes trusted=yes] https://download.opensuse.org/repositories/home:/FrodeSolheim:/stable/Debian_10/ /" | sudo tee /etc/apt/sources.list.d/FrodeSolheim-stable.list

# MongoDB
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.4 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

# NodeJS
curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Update repositories and update
apt update --allow-unauthenticated

apt autoremove

## Spotify, i3, Docker

apt -qq remove -y docker docker-engine docker.io

apt -qq install -y \
    android-tools-adb \
    android-tools-fastboot \
    arandr \
    ant \
    autoconf \
    build-essential \
    ca-certificates \
    ccache \
    clang \
    cmake \
    cmake-data \
    compton \
    cppcheck \
    cpufrequtils \
    curl \
    default-jdk \
    dh-autoreconf \
    dirmngr \
    docker-ce \
    emacs \
    feh \
    firmware-iwlwifi \
    firmware-linux \
    fonts-materialdesignicons-webfont \
    gimp \
    global \
    gnupg2 \
    google-chrome-stable \
    hdparm \
    i2c-tools \
    i3lock \
    iotop \
    imagemagick \
    irssi \
    libappindicator3-1 \
    libssl1.1 \
    libjsoncpp-dev \
    libsecret-1-0 \
    libsecret-1-dev \
    libsecret-tools \
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
    libqt5serialport5-dev \
    libxcb-util0-dev \
    libxcb-composite0-dev \
    libcairo2-dev \
    libiw-dev \
    libxcb1-dev \
    libxcb-image0-dev \
    libxcb-ewmh-dev \
    libboost-all-dev \
    lightdm \
    linux-perf \
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
    libxcb-xrm-dev \
    libxcb-shape0 \
    libxcb-shape0-dev \
    libxcb1-dev \
    libxcb-util0-dev \
    libxcb-randr0-dev \
    libxcb-composite0-dev \
    mc \
    meld \
    meson \
    minicom \
    mongodb-org \
    nvme-cli \
    net-tools \
    nfs-common \
    nodejs \
    npm \
    pavucontrol \
    pkg-config \
    python-dev \
    python3-pip \
    python-xcbgen \
    qtcreator \
    read-edid \
    rofi \
    rxvt-unicode \
    screen \
    silversearcher-ag \
    spotify-client \
    software-properties-common \
    tcpdump \
    wireshark \
    xcb \
    xcb-proto \
    xkeycaps \
    xsel \
    virtualenv \
    zsh

apt -qq install -y -t buster-backports \
    nvidia-driver \
    nvidia-settings \
    git-review \
    gitk \

# Node
npm install -g @angular/cli

# FS-UAE
apt -qq install -y --allow-unauthenticated fs-uae fs-uae-launcher fs-uae-arcade

# Python
pip3 install --upgrade setuptools pip
#pip3 install numpy scipy
#pip3 install -U scikit-learn
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
    sudo -u $SUDO_USER git clone https://www.github.com/Airblader/i3 $EXTERNAL/i3-gaps
    cd "$EXTERNAL/i3-gaps"
fi

# compile & install
sudo -u $SUDO_USER mkdir -p build && cd build
sudo -u $SUDO_USER meson ..
sudo -u $SUDO_USER ninja
meson install

#sudo -u $SUDO_USER autoreconf --force --install
#sudo -u $SUDO_USER rm -rf build/
#sudo -u $SUDO_USER mkdir -p build
#cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
#sudo -u $SUDO_USER ../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
#sudo -u $SUDO_USER make
#sudo make install

## Powerline fonts
if [ -d "$EXTERNAL/powerline-fonts" ]; then
    cd "$EXTERNAL/powerline-fonts" && git pull
else
    sudo -u $SUDO_USER git clone https://github.com/powerline/fonts.git "$EXTERNAL/powerline-fonts"
    cd "$EXTERNAL/powerline-fonts"
fi

sudo -u $SUDO_USER ./install.sh

## Polybar

POLYBAR_FILE="polybar-3.5.0.tar"
sudo -u $SUDO_USER mkdir -p "downloads"
sudo -u $SUDO_USER wget "https://github.com/jaagr/polybar/releases/download/3.5.0/$POLYBAR_FILE" -P downloads/
sudo -u $SUDO_USER tar xvf "downloads/$POLYBAR_FILE" -C "$EXTERNAL/"

cd "$EXTERNAL/polybar"

rm -rf build
sudo -u $SUDO_USER mkdir build
cd build
sudo -u $SUDO_USER cmake ..
make install

rm -rf downloads/$POLYBAR_FILE


## Repo

sudo -u $SUDO_USER curl -o /home/$SUDO_USER/bin/repo https://storage.googleapis.com/git-repo-downloads/repo
sudo -u $SUDO_USER chmod a+x /home/$SUDO_USER/bin/repo

# Log directory
mkdir -p "/home/$SUDO_USER/logs/minicom"

## Cocos2dx
if [ -d "$EXTERNAL/cocos2d-x" ]; then
    cd "$EXTERNAL/cocos2d-x" && git pull
else
    sudo -u $SUDO_USER git clone https://github.com/cocos2d/cocos2d-x.git "$EXTERNAL/cocos2d-x"
    cd "$EXTERNAL/cocos2d-x"
fi

sudo -u $SUDO_USER python download-deps.py
sudo -u $SUDO_USER git submodule update --init

# ZShell
USING_ZSH=$(cat /etc/passwd | grep $SUDO_USER | grep zsh) || true
if [ -z "$USING_ZSH" ]
then
    echo "Changing default shell to zsh"
    sudo -u $SUDO_USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    ZSH_PATH=`which zsh`
    sudo -u $SUDO_USER chsh -s "$ZSH_PATH"
fi

# Fix groups
sudo usermod -aG sudo,docker,plugdev,dialout,wireshark $SUDO_USER

# Copy udev rules
cp *.rules /etc/udev/rules.d/

# Copy clproj.sh to bin
sudo -u $SUDO_USER mv clproj.sh /home/$SUDO_USER/bin
