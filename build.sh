#!/usr/bin/env bash
url=`cat ./.git/config | grep "url = " | sed "s/^[^=]*= //"`
if [[ $url == "https://github.com/stardust-kyun/calla" ]]; then # make this case insensitive
	read -p "
Which distro would you like to build for?

(1) Debian
(2) Arch

(?) Select option: " dist
	case $dist in
		"1")
			mkdir -p package # doesn't work
			read -p "Version (0.1.0-1): " ver
			cp -r src/usr package/
			cp -r DEBIAN package/
			
			dpkg-deb --build package calla_$ver\_amd64.deb
			rm -rf package
			;;
		"2")
			makepkg -f --noconfirm
			;;
		*)
			echo "Something went wrong. Did you choose an option correctly?"
			exit
	esac
else
	echo "Something went wrong. Are you inside the project directory?"
fi
