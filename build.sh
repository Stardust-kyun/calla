#!/usr/bin/env bash
url=`cat ./.git/config | grep "url = " | sed "s/^[^=]*= //"`
if [[ $url == "https://github.com/LeVraiArdox/calla.git" ]]; then
	read -p "
Which distro would you like to build for?

(1) Debian
(2) Arch

(?) Select option: " dist
	case $dist in
		"1")
			mkdir -p package
			read -p "Version (0.1.0-1): " ver
			cp -r src/usr package/
			cp -r DEBIAN package/
			
			dpkg-deb --build package calla_$ver\_amd64.deb
			rm -rf package
			;;
		"2")
			makepkg -f --noconfirm --clean
			;;
		*)
			echo "Something went wrong. Did you choose an option correctly?"
			exit
	esac
else
	echo "Something went wrong. Are you inside the project directory?"
fi
