#!/usr/bin/env bash

set -e

EXTERNAL="$HOME/sources/external"
APPS="$HOME/apps/"

mkdir -p "$EXTERNAL" && mkdir -p "$APPS"

# Add keys

## Spotify

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90

echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list


## Chrome

wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list


## Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"


# Update repositories and update

sudo apt update

sudo apt autoremove

## Spotify, i3, Docker

sudo apt -qq remove -y docker docker-engine docker.io

sudo apt -qq install -y \
     software-properties-common \
     dh-autoreconf \
     curl \
     nvidia-driver \
     dirmngr \
     libssl1.0.2 \
     emacs \
     zsh \
     hexchat \
     xfce4-terminal \
     feh \
     mc \
     irssi \
     screen \
     rofi \
     arandr \
     \
     spotify-client \
     \
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
     \
     google-chrome-stable \
     \
     dh-autoreconf \
     libxcb1-dev \
     libxcb-keysyms1-dev \
     libpango1.0-dev \
     libxcb-util0-dev \
     libxcb-icccm4-dev \
     libyajl-dev \
     libstartup-notification0-dev \
     libxcb-randr0-dev \
     libev-dev \
     libxcb-cursor-dev \
     libxcb-xinerama0-dev \
     libxcb-xkb-dev \
     libxkbcommon-dev \
     libxkbcommon-x11-dev \
     autoconf \
     libxcb-xrm-dev \
     python-pip \
     python-dev \
     python3-distutils \
     build-essential \
     openjdk-8-jdk \
     pidgin \
     pidgin-sipe \
     i2c-tools \
     silversearcher-ag \
     cpufrequtils \
     nodejs \
     global \
     ccache \
     cmake \
     ant \
     gimp \
     git-review \
     cppcheck \
     meld \
     apt-transport-https \
     ca-certificates \
     gnupg2 \
     software-properties-common \
     docker-ce \
     read-edid \
     libiw-dev \
     python-xcbgen \
     xcb-proto \
     cmake \
     cmake-data \
     pkg-config \
     libxcb-image0-dev \
     libxcb-ewmh-dev \
     xkeycaps \
     fonts-materialdesignicons-webfont \
     compton \
     imagemagick \
     nfs-common \
     libpulse-dev \
     libasound2-dev \
     libnl-3-dev \
     libxcb1-dev \
     libxcb-util0-dev \
     libxcb-randr0-dev \
     libxcb-composite0-dev \
     libcairo2-dev \
     python-pip \
     python3-pip \
     virtualenv \
     libsecret-1-0 \
     libsecret-1-dev \
     minicom \
     hdparm \
     i3lock \
     fs-uae \
     fs-uae-launcher \
     fs-uae-arcade

sudo pip3 install --upgrade setuptools pip
sudo pip3 install numpy scipy
sudo pip3 install -U scikit-learn
sudo pip3 install pywal


# KVM
#sudo apt -qq install -y qemu-kvm libvirt-bin ubuntu-vm-builder bridge-utils

# Docker Compose

sudo curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

## i3-gaps
if [ -d "$EXTERNAL/i3-gaps" ]; then
    cd "$EXTERNAL/i3-gaps" && git pull
else
    git clone https://www.github.com/Airblader/i3 i3-gaps
    cd "$EXTERNAL/i3-gaps"
fi

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
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
if [ -d "$EXTERNAL/polybar" ]; then
    cd "$EXTERNAL/polybar" && git pull
else
    rm -rf "$EXTERNAL/polybar"
    git clone --branch 3.2 --recursive https://github.com/jaagr/polybar "$EXTERNAL/polybar"
    cd "$EXTERNAL/polybar"
    mkdir build
fi

cd build
cmake ..
sudo make install


## Cocos2dx
if [ -d "$EXTERNAL/cocos2d-x" ]; then
    cd "$EXTERNAL/cocos2d-x" && git pull
else
    git clone https://github.com/cocos2d/cocos2d-x.git "$EXTERNAL/cocos2d-x"
    cd "$EXTERNAL/cocos2d-x"
fi
python download-deps.py
git submodule update --init


## Repo
mkdir $HOME/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
