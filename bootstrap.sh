#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ROOT_DOTFILES_DIR=$SCRIPT_DIR

echo "Starting bootstrapping"

# Apt
echo "Installing applications"
APP_INSTALL_SCRIPT="$ROOT_DOTFILES_DIR/debian/app-install.sh"
bash "$APP_INSTALL_SCRIPT"

# ZShell
ZSH_PATH=`which zsh`
echo "Changing default shell to zsh"
chsh -s "$ZSH_PATH"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Log directory
mkdir -p "$HOME/logs/minicom"

echo "Bootstrapping completed"
