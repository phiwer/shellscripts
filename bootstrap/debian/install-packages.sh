#!/usr/bin/env bash

set -e

# NodeJS
#curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Update repositories and update
sudo apt update

sudo apt autoremove

sudo apt -qq install -y \
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
    curl \
    default-jdk \
    dh-autoreconf \
    dirmngr \
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
    linux-cpupower \
    mc \
    meld \
    meson \
    minicom \
    nvme-cli \
    net-tools \
    nfs-common \
    nodejs \
    npm \
    pavucontrol \
    pkg-config \
    python-dev-is-python3 \
    python3-pip \
    qtcreator \
    read-edid \
    rofi \
    rxvt-unicode \
    screen \
    silversearcher-ag \
    software-properties-common \
    tcpdump \
    wireshark \
    wget \
    xcb-proto \
    xkeycaps \
    xsel \
    virtualenv \
    zsh \
    tig \
    git-review \
    gitk \
    i3


# Log directory
#mkdir -p "/home/$SUDO_USER/logs/minicom"


# Copy clproj.sh to bin
#sudo -u $SUDO_USER mv clproj.sh /home/$SUDO_USER/bin
