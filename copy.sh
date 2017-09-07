#!/bin/bash

git clone https://github.com/lgAshanl/i3-config

name=$(whoami)
path="/home/$name/.config/i3"
git_path="./i3-config"
version=$(cat $git_path'/v')
if [ -f "$path/v" ]; then
   echo "File $FILE exists."
	$local_version=$(cat $path'/v')
else
   $local_version='0'
fi
echo $version
echo $local_version

if [ $version > $local_version ]; then
	cp -rf $git_path/config $path
	cp -rf $git_path/status.toml $path
	cp -rf $git_path/copy.sh $path
	cp -rf $git_path/v $path
fi

rm -r $git_path

#sudo pacman -S polkit-gnome gnome-keyring -y
#sudo pacman -S alsa-utils lm_sensors gperftools powerline-fonts feh dmenu -y
#yaourt -S speedtest-cli ttf-font-awesome i3status-rust-git -y

