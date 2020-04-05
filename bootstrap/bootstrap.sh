#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ROOT_DOTFILES_DIR=$SCRIPT_DIR

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

echo "Starting bootstrapping"

# Apt
echo "Installing applications"
APP_INSTALL_SCRIPT="$ROOT_DOTFILES_DIR/debian/client-install.sh"
sh "$APP_INSTALL_SCRIPT"

# ZShell
USING_ZSH=$(cat /etc/passwd | grep $SUDO_USER | grep zsh)
echo $USING_ZSH
if [ -z  $USING_ZSH ]; then
    echo "Changing default shell to zsh"
    sudo -u $SUDO_USER sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    ZSH_PATH=`which zsh`
    sudo -u $SUDO_USER chsh -s "$ZSH_PATH"
fi

# Log directory
mkdir -p "$HOME/logs/minicom"

echo "Bootstrapping completed"
