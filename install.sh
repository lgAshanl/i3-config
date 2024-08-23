#!/bin/bash
name=$(whoami)
dist=$(cat /etc/os-release | grep -o 'ID=\w*' | grep -oE 'arch|debian|ubuntu')
echo $dist

if [[ $dist = 'arch' ]]; then
	sudo pacman -Syu -y
	sudo pacman -S breeze-gtk breeze-icons -y
	sudo pacman -S audacious audacious-plugins gedit gedit-plugins rustup fish -y
	yaourt -S maia-gtk-theme google-chrome -y
elif [[ $dist = 'ubuntu' ]]; then
	cur_dir=$(pwd)
	mkdir /tmp/init_installation
	cd /tmp/init_installation

	# Full update
	sudo apt update -y -f
	sudo apt dist-upgrade -y
	sudo apt update -y -f -q
	sudo apt upgrade -y

	# Base packages
	sudo apt install gtk3-engines-breeze breeze-icon-theme audacious audacious-plugins -y
	sudo apt install gedit gedit-plugins fish curl libssl-dev pkg-config libsensors-dev -y
	sudo apt install nemo -y

	# Browser
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	rm google-chrome-stable_current_amd64.deb

	# The best language
	curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly
	rustup completions bash > /etc/bash_completion.d/rustup.bash-completion
	rustup completions fish > ~/.config/fish/completions/rustup.fish
	rm sh.rustup.rs

	cd $cur_dir
	rm -rf /tmp/init_installation
else
	echo "shit, unknown os"
	exit 1
fi

sudo chsh -s /usr/bin/fish $name

./copy.sh
