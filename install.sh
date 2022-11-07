#!/bin/env bash

step_1(){

  echo -e "\n[ Step 1 ] System update\n"
  sudo pacman -Syu --noconfirm
  sleep 3; clear
}

step_2(){
cat << EOF

[ Step 2 ] AUR Helper

(1) yay
(2) paru

EOF

  read -p "(?) Select option: " ans_2
  if [[ $ans_2 == "1" ]] || [[ $ans_2 == "yay" ]]; then
    HELPER="yay"
    if ! command -v $HELPER &> /dev/null; then
      sudo pacman -S git --noconfirm --needed
      git clone https://aur.archlinux.org/$HELPER.git /tmp/$HELPER
      (cd /tmp/$HELPER/ && makepkg -si --noconfirm --needed PKGBUILD)
      sleep 3; clear
    else
      echo -e "\n(*) It seems that you already have $HELPER installed, skipping..."
      sleep 3; clear
    fi
    
  elif [[ $ans_2 == "2" ]] || [[ $ans_2 == "paru" ]]; then
    HELPER="paru"
    if ! command -v $HELPER &> /dev/null; then
      sudo pacman -S git --noconfirm --needed
      git clone https://aur.archlinux.org/$HELPER.git /tmp/$HELPER
      (cd /tmp/$HELPER/ && makepkg -si --noconfirm --needed PKGBUILD)
      sleep 3; clear
    else
      echo -e "\n(*) It seems that you already have $HELPER installed, skipping..."
      sleep 3; clear
    fi
  else
    echo -e "\n(!) Invalid option, select one to continue"
    sleep 3; clear
  fi
}

step_3(){
cat << EOF

[ Step 3 ] Dependecies

EOF

  sleep 3;
  $HELPER -S base-devel --needed
  yes | $HELPER -S xdg-user-dirs awesome-git lightdm lightdm-webkit2-greeter light-locker gvim librewolf-bin nemo gd rofi ttf-roboto \
  ttf-roboto-mono xsettingsd picom network-manager-applet xcursor-breeze inotify-tools light maim zathura \
  viewnior polkit-gnome noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra --needed
  sleep 3; clear
}

step_4(){
cat << EOF

[ Step 4 ] Setup dotfiles

EOF

  sudo mkdir -p /usr/share/themes
  sudo mkdir -p /usr/share/fonts/TTF

  cd home/
  cp -rf . ~/
  cd ../usr/share/
  sudo cp -rf . /usr/share/
  sudo cp fonts/TTF/* /usr/share/fonts/TTF/
  cd ../bin/
  sudo cp -rf . /usr/bin/
  xrdb ~/.Xresources

  cd ~/.config/st
  sudo make install

  xdg-user-dirs-update
  sudo sed -i 's/#greeter-session.*/greeter-session=lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf
  sudo sed -i 's/webkit_theme.*/webkit_theme = minimal/g' /etc/lightdm/lightdm-webkit2-greeter.conf
  sudo systemctl enable lightdm
  sudo systemctl enable NetworkManager
  sudo rm -rf /tmp/dotfiles/

  cd ~
  chmod u+x .config/rofi/*
  chmod u+x .config/awesome/bin/*
  fc-cache -fv
  sleep 3; clear

  echo "Installation complete, thank you for using my dotfiles!"
  echo "This script was made by Qwickdom and Stardust-kyun."
  echo "Would you like to reboot?"
  echo "(1) yes   (2) no"
  read -r -p "(default 1): " rbt
  if [[ $rbt -eq 2 ]]; then
	echo -e "\nSkipping..."
    sleep 3; clear
  else
    sleep 3; clear
	systemctl reboot
  fi
}

clear
read -p "Hello $USER! This script will install my dotfiles on your system, and may result in losing some existing configs. Would you like to continue?

(1) yes
(*) no

" ans_1
if [[ $ans_1 == "1" ]] || [[ $ans_1 == "yes" ]]; then

sleep 3;
clear
step_1

while [[ $ans_2 != "1" ]] && [[ $ans_2 != "2" ]] && [[ $ans_2 != "yay" ]] && [[ $ans_2 != "paru" ]]; do
  step_2
done

step_3
step_4

else
	exit
fi
