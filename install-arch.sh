#!/bin/env bash

step_1(){
cat << EOF

[ Step 1 ] System Update

EOF

  sleep 3;
  sudo pacman -Syu --noconfirm
  clear
}

step_2(){
cat << EOF

[ Step 2 ] AUR Helper

EOF

if ! command -v yay &> /dev/null; then
  sudo pacman -S git --noconfirm --needed
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay/ && makepkg -si --noconfirm --needed PKGBUILD)
  sleep 3; clear
else
  echo -e "\n(*) It seems that you already have yay installed, skipping..."
  sleep 3; clear
fi
}

step_3(){
cat << EOF

[ Step 3 ] Dependecies

(1) Full installation: Includes my preferred programs and utilities
(2) Minimal installation: Base system only

EOF

  read -p "(?) Select option: " ans_3
  if [[ $ans_3 == "1" ]]; then
	sleep 3;
	  yay -S base-devel --needed
      yes | yay -S xclip xorg-xprop xdg-user-dirs awesome-git lightdm lightdm-webkit2-greeter light-locker gvim librewolf-bin nemo gd rofi ttf-roboto \
      ttf-roboto-mono xsettingsd picom network-manager-applet cbatticon volumeicon papirus-icon-theme xcursor-breeze inotify-tools light maim zathura \
      viewnior polkit-gnome noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra --needed
    sleep 3; clear
    
  elif [[ $ans_3 == "2" ]]; then
	sleep 3;
	  yay -S base-devel --needed
      yes | yay -S xclip xorg-xprop xdg-user-dirs awesome-git lightdm lightdm-webkit2-greeter light-locker rofi ttf-roboto \
      ttf-roboto-mono xsettingsd picom papirus-icon-theme xcursor-breeze inotify-tools light maim \
      polkit-gnome noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra --needed
    sleep 3; clear
  else
    echo -e "\n(!) Invalid option, select one to continue"
    sleep 3; clear
  fi
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
  if [[ $ans_3 == "1" ]]; then
    cd ../../lib/librewolf/
    sed -i "s/USER/`whoami`/g" mozilla.cfg
    sudo cp -r . /lib/librewolf/
  fi
  sudo rm -rf ~/dotfiles/

  sudo sed -i "s/#greeter-session.*/greeter-session=lightdm-webkit2-greeter/g" /etc/lightdm/lightdm.conf
  sudo sed -i "s/webkit_theme.*/webkit_theme = minimal/g" /etc/lightdm/lightdm-webkit2-greeter.conf
  sudo systemctl enable lightdm
  if [[ $ans_3 == "1" ]]; then
    sudo systemctl enable NetworkManager
  fi

  cd ~
  chmod u+x .config/rofi/*
  chmod u+x .config/awesome/bin/*

  if [[ $ans_3 == "1" ]]; then
    cd ~/.config/st
    sudo make install
  fi

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
  while [[ $ans_3 != "1" ]] && [[ $ans_3 != "2" ]]; do
    step_3
  done
  step_4
else
  exit
fi
