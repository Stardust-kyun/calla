#!/bin/env bash

step_1(){
cat << EOF

[ Step 1 ] System Update

EOF

  sleep 3;
  echo "Updating the system..."
  sudo xbps-install -Syu 
  echo "Updated the system!"
  sleep 1; clear
}


step_2(){
cat << EOF

[ Step 2 ] Dependecies

EOF

  sleep 3;
  echo "Installing system dependencies..."
  sudo xbps-install -Sy \
  base-devel xclip xprop xdg-user-dirs lightdm lightdm-webkit2-greeter light-locker \
  rofi fonts-roboto-ttf xsettingsd xrdb elogind xorg \
  picom breeze-cursors inotify-tools light maim \
  polkit-gnome noto-fonts-ttf noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf-extra 
  echo "Installed system dependencies!"
  sleep 1; clear
}

step_3(){
cat << EOF

[ Step 3 ] Awesome-git Installation

EOF

  sleep 3;
  echo "Installing awesome-git dependencies..."
  sudo xbps-install -Sy cmake ruby-asciidoctor ImageMagick pkg-config libxcb-devel pango-devel xcb-util-devel xcb-util-image-devel \
  xcb-util-keysyms-devel xcb-util-wm-devel xcb-util-cursor-devel startup-notification-devel libxdg-basedir-devel \
  gdk-pixbuf-devel dbus-devel libxkbcommon-devel xcb-util-xrm-devel dbus-x11 pango
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
  sudo touch /etc/sv/lightdm/down
  sudo ln -s /etc/sv/lightdm /var/service
  sudo ln -s /etc/sv/dbus /var/service

  cd ~
  chmod u+x .config/rofi/*
  chmod u+x .config/awesome/bin/*

  fc-cache -fv
  xrdb ~/.Xresources
  xdg-user-dirs-update
  mkdir ~/Pictures/Screenshots
  sleep 3; clear

  read -r -p "
Installation complete, thank you for using my dotfiles!
This script was made by Qwickdom and Stardust-kyun.
Would you like to reboot?

(1) yes
(*) no

(?) Select option: " rbt
  if [[ $rbt -eq 1 ]]; then
  sleep 3; clear
    sudo rm /var/service/lightdm/down
	loginctl reboot
  else
	echo -e "\nSkipping..."
    sudo rm /var/service/lightdm/down
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
