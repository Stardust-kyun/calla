#!/bin/env bash

step_1(){
cat << EOF

[ Step 1 ] System Update

EOF

  sleep 3;
  echo "Updating the system..."
  sudo apk upgrade -y 
  echo "Updated the system!"
  sleep 1; clear
}


step_2(){
cat << EOF

[ Step 2 ] Dependencies

EOF
  echo "Installing X..."
  sudo apk add alpine-base
  sleep 3;
  sudo setup-xorg-base
  sleep 3;
  sudo apk add xf86-input-mouse xf86-input-synaptics af86-input-evdev libinput

  sleep 3;
  echo "Enabling Udev & Dbus"
  sudo rc-update add dbus
  sleep 3;
  sudo rc-update add udev

  sleep 3;
  echo "Installing system dependencies..."
  sudo apk add xclip xprop xdg-user-dirs lightdm light-locker \
    rofi font-roboto font-roboto-mono xsettingsd picom \
    breeze breeze-icons inotify-tools light maim \
    polkit-gnome font-noto-cjk font-noto-cjk-extra font-noto-emoji -y 

  echo "Installed system dependencies!"
  sleep 1; clear
}

step_3(){
cat << EOF

[ Step 3 ] Awesome-git Installation

EOF
  sleep 3;
  echo "Installing awesome-git dependencies..."
  sudo apk add cairo-dev cmake dbus-dev gdk-pixbuf-dev glib-dev gperf imlib2-dev libev-dev libxcb-dev libxdg-basedir-dev libxkbcommon-dev lua-doc lua5.1-dev pango-dev samurai startup-notification-dev xcb-util-cursor-dev xcb-util-dev xcb-util-image-dev xcb-util-keysyms-dev xcb-util-wm-dev xcb-util-xrm-dev lua5.1-lgi 
  clear

  echo "Cloning awesome-git repository..."
  git clone https://github.com/awesomeWM/awesome /tmp/awesome-git 
  pushd /tmp/awesome-git
  clear
  echo "Compiling awesome-git..."
  make 
  sudo make install 
  clear
  popd
  echo "Finished compiling awesome!"
}

step_4(){
cat << EOF

[ Step 4 ] Setup Dotfiles

EOF

  sleep 3;

  echo "Copying files, please wait..."

  cd home/
  cp -r . ~/
  cd ../usr/share/
  sudo cp -r . /usr/share/
  cd ../bin/
  sudo cp -r . /usr/bin/
  sudo rm -rf ~/dotfiles/

  sudo sed -i "s/#greeter-session.*/greeter-session=lightdm-webkit2-greeter/g" /etc/lightdm/lightdm.conf
  sudo sed -i "s/webkit_theme.*/webkit_theme = minimal/g" /etc/lightdm/lightdm-webkit2-greeter.conf

  sudo systemctl enable lightdm

  cd ~
  chmod u+x .config/awesome/bin/*

  fc-cache -fv
  xrdb ~/.Xresources
  xdg-user-dirs-update
  mkdir ~/Pictures/Screenshots
  sleep 3; clear

  read -r -p "
Installation complete, thank you for using my dotfiles!
This script was made by AloneERO.
Would you like to reboot?

(1) yes
(*) no

(?) Select option: " rbt
  if [[ $rbt -eq 1 ]]; then
  sleep 3; clear
	  systemctl reboot
  else
	echo -e "\nSkipping..."
  sleep 3; clear
  fi
}

clear
read -p "
Hello $USER! This script will install my dotfiles on your system 
And may result in losing some existing configs. 
Would you like to continue?

(1) yes
(*) no

(?) Select option: " ans_1
if [[ $ans_1 == "1" ]]; then

sleep 3;
clear
	step_1
	step_2
	step_3
	step_4
else
	exit
fi
