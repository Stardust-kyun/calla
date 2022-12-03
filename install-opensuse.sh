#!/bin/env bash

step_1(){
cat << EOF

[ Step 1 ] System Update

EOF

  sleep 3;
  echo "Updating the system..."
  sudo zypper dup -y 
  echo "Updated the system!"
  sleep 1; clear
}


step_2(){
cat << EOF

[ Step 2 ] Dependecies

EOF

  sleep 3;
  echo "Installing system dependencies..."
  sudo zypper install xclip xprop xdg-user-dirs lightdm light-locker \
    rofi google-roboto-fonts google-roboto-mono-fonts xsettingsd picom \
    breeze5-cursors inotify-tools light maim \
    polkit-gnome noto* -y 

  echo "Installed system dependencies!"
  sleep 1; clear
}

step_3(){
cat << EOF

[ Step 3 ] Awesome-git Installation

EOF
  sleep 3;
  echo "Enabling openSUSE source repo..."
  sudo zypper mr -e 8  

  sleep 3;
  echo "Installing awesome-git dependencies..."
  sudo zypper si awesome
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
