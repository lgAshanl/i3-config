#!/bin/bash
name=$(whoami)

sudo pacman -Suy -y
sudo pacman -S breeze-gtk breeze-icons nvdock -y
sudo pacman -S audacious audacious-plugins gedit gedit-plugins rust fish -y
yaourt -S maia-gtk-theme google-chrome -y

sudo chsh -s /usr/bin/fish $name

./copy.sh
