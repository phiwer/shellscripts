#!/usr/bin/env bash

## TODO: Add non-free and contrib to sources.list

set -e

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

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
#curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D1742AD60D811D58
#echo "deb [allow-insecure=yes trusted=yes arch=amd64] http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

## Chrome
#wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
#echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list

## Docker

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Add FS-UAE repository1
#wget -q -O - https://download.opensuse.org/repositories/home:FrodeSolheim:stable/Debian_10/Release.key | sudo apt-key add -
#echo "deb [allow-insecure=yes trusted=yes] https://download.opensuse.org/repositories/home:/FrodeSolheim:/stable/Debian_10/ /" | sudo tee /etc/apt/sources.list.d/FrodeSolheim-stable.list

# MongoDB
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.4 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list

# NodeJS
curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Update repositories and update
apt update --allow-unauthenticated

apt -qq autoremove

## Spotify, i3, Docker
apt -qq remove -y docker docker-engine docker.io

apt -qq install -y \
    android-tools-adb \
    android-tools-fastboot \
    arandr \
    ant \
    autoconf \
    bison \
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
    flex \
    fontconfig \
    fonts-materialdesignicons-webfont \
    fonts-powerline \
    gcc \
    gcc-multilib \
    g++ \
    git-core \
    gimp \
    global \
    gnupg \
    gnupg2 \
    google-chrome-stable \
    hdparm \
    i2c-tools \
    i3lock \
    iotop \
    imagemagick \
    irssi \
    libc6-dev-i386 \
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
    libxml2-utils \
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
    libgl1-mesa-dev \
    libpulse-dev \
    libasound2-dev \
    libnl-3-dev \
    libncurses5 \
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
    libxcb-keysyms1-dev \
    libpango1.0-dev \
    libxcb-util0-dev \
    lib32z1-dev \
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
    make \
    mc \
    meld \
    meson \
    minicom \
    mongodb-org \
    nvme-cli \
    net-tools \
    nfs-common \
    nodejs \
    pavucontrol \
    pkg-config \
    python-dev \
    python3-xcbgen \
    python3-pip \
    qtcreator \
    read-edid \
    rofi \
    rxvt-unicode \
    screen \
    silversearcher-ag \
    software-properties-common \
    tcpdump \
    unzip \
    wireshark \
    xcb \
    xcb-proto \
    xkeycaps \
    xsel \
    xsltproc \
    x11proto-core-dev \
    virtualenv \
    zlib1g-dev \
    zsh \
    zip 

# Node
npm install -g @angular/cli

# FS-UAE
#apt -qq install -y --allow-unauthenticated fs-uae fs-uae-launcher fs-uae-arcade

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

## Polybar
POLYBAR_VERSION="3.5.7"
POLYBAR_FILE="polybar-$POLYBAR_VERSION.tar.gz"
POLYBAR_DIR="polybar-$POLYBAR_VERSION"
#sudo -u $SUDO_USER mkdir -p "/home/$SUDO_USER/Downloads"
sudo -u $SUDO_USER wget "https://github.com/polybar/polybar/releases/download/$POLYBAR_VERSION/$POLYBAR_FILE" -P "~/Downloads/"
sudo -u $SUDO_USER tar zxvf "~/Downloads/$POLYBAR_FILE" -C "$EXTERNAL/"

cd "$EXTERNAL/$POLYBAR_DIR"

#rm -rf build
sudo -u $SUDO_USER mkdir -p build
cd build
sudo -u $SUDO_USER cmake ..
make install

rm -rf "~/Downloads/$POLYBAR_FILE"


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

sudo -u $SUDO_USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Fix groups
sudo usermod -aG sudo,docker,plugdev,dialout,wireshark $SUDO_USER

# Copy udev rules
sudo cp "$SCRIPTPATH/*.rules" /etc/udev/rules.d/

# Copy clproj.sh to bin
sudo -u $SUDO_USER cp "$SCRIPTPATH/clproj.sh" /home/$SUDO_USER/bin
