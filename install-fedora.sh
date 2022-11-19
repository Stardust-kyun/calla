#!/bin/env bash

step_1(){
cat << EOF

[ Step 1 ] System Update

EOF

  sleep 3;
  echo "Updating the system..."
  sudo dnf update -y 
  echo "Updated the system!"
  sleep 1; clear
}


step_2(){
cat << EOF

[ Step 2 ] Dependecies

EOF
  sleep 2;
  echo "Installing dnf-plugins-core.."
  sudo dnf install dnf-plugins-core -y 

  sleep 2;
  echo "Enabling lightdm-webkit2.."
  sudo dnf copr enable antergos/lightdm-webkit2-greeter 

  sleep 2;
  echo "Installing Librewolf.."
  sudo rpm --import https://keys.openpgp.org/vks/v1/by-fingerprint/034F7776EF5E0C613D2F7934D29FBD5F93C0CFC3 

  sudo dnf config-manager --add-repo https://rpm.librewolf.net -y

  sudo dnf install --refresh librewolf -y 

  sleep 3;
  echo "Installing system dependencies..."
  sudo dnf install xclip xprop xdg-user-dirs lightdm lightdm-webkit2-greeter light-locker vim-X11 nemo libgda-devel harfbuzz-devel \
    libXext-devel libXrender-devel libXinerama-devel rofi google-roboto-fonts google-roboto-mono-fonts xsettingsd picom \
    network-manager-applet breeze-cursor-theme inotify-tools light maim zathura viewnior \
    polkit-gnome google-noto-cjk-fonts google-noto-fonts-common google-noto-emoji-fonts -y 

  echo "Installed system dependencies!"
  sleep 1; clear
}

step_3(){
cat << EOF

[ Step 3 ] Awesome-git Installation

EOF
  sleep 3;
  echo "Installing awesome-git dependencies..."
  sudo dnf build-dep awesome -y 
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
  cd ../../lib/librewolf/
  sed -i "s/USER/`whoami`/g" mozilla.cfg
  sudo cp -r . /lib/librewolf/
  sudo rm -rf ~/dotfiles/

  sudo sed -i "s/#greeter-session.*/greeter-session=lightdm-webkit2-greeter/g" /etc/lightdm/lightdm.conf
  sudo sed -i "s/webkit_theme.*/webkit_theme = minimal/g" /etc/lightdm/lightdm-webkit2-greeter.conf

  sudo systemctl enable lightdm
  sudo systemctl enable NetworkManager

  cd ~
  chmod u+x .config/rofi/*
  chmod u+x .config/awesome/bin/*

  cd ~/.config/st
  sudo make install

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
