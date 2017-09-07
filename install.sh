#!/bin/bash
name=$(whoami)

#sudo pacman -Suy -y
#sudo pacman -S breeze-gtk breeze-icons
#sudo pacman -S audacious audacious-plugins gedit gedit-plugins rust fish
#yaourt -S maia-gtk-theme google-chrome 

sudo chsh -s /usr/bin/fish $name

./copy.sh
