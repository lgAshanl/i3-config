#!/bin/bash
# Dancing for good work i3

dist=$(cat /etc/os-release | grep -o 'ID=\w*' | grep -oE 'arch|debian')

git clone https://github.com/lgAshanl/i3-config

# Config
name=$(whoami)
path="/home/$name/.config/i3"
mkdir $path
git_path="./i3-config"
version=$(cat $git_path'/v')
if [ -f "$path/v" ]; then
	echo "File $FILE exists."
	local_version=$(cat $path'/v')
else
	local_version=0
fi
echo "to " $version
echo "from " $local_version

if [[ "$version" > "$local_version" ]]; then
	cp -rf $git_path/config $path
	cp -rf $git_path/status.toml $path
	cp -rf $git_path/copy.sh $path
	cp -rf $git_path/v $path
fi

sudo rm -r $git_path

# Packages
if [[ $dist = 'arch' ]]; then
	sudo pacman -S polkit-gnome gnome-keyring -y
	sudo pacman -S alsa-utils lm_sensors gperftools powerline-fonts feh dmenu -y
	yaourt -S speedtest-cli ttf-font-awesome i3status-rust-git -y
elif [[ $dist = 'debian' ]]; then
	sudo apt install gnome-keyring alsa-utils lm-sensors google-perftools fonts-powerline feh i3 speedtest-cli fonts-font-awesome -y
	sudo apt install dpkg debconf debhelper lintian

	cur_dir=$(pwd)
	mkdir /tmp/i3-status-rust
	cd /tmp/i3-status-rust

	git clone https://github.com/greshake/i3status-rust
	cd i3status-rust && cargo build --release
	cp target/release/i3status-rs ~/bin/i3status-rs

	cd $cur_dir
	rm -rf /tmp/i3-status-rust
else
	echo "shit, unknown os"
	exit 1
fi

