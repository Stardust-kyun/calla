#!/bin/env bash

step_1(){
cat << EOF

[ Step 1 ] System Update

EOF

  sleep 3;
  su -c 'apt update' 
  clear
}

step_2(){
cat << EOF

[ Step 2 ] Dependencies

EOF

	sleep 3; clear
      su -c 'apt install -y xclip xdg-user-dirs lightdm light-locker rofi fonts-roboto \
       xsettingsd picom papirus-icon-theme breeze-cursor-theme inotify-tools light maim \
      policykit-1-gnome fonts-noto fonts-noto-cjk fonts-noto-color-emoji fonts-noto-cjk-extra'
    sleep 3; clear
}

step_3(){
cat << EOF

[ Step 3 ] Awesome-git, Lightdm, Roboto Mono Installation

EOF

	sleep 3; clear
	  su -c 'apt build-dep -y awesome'
	  git clone https://github.com/awesomeWM/awesome /tmp/awesome-git
	  pushd /tmp/awesome-git
	  clear
	  make package
	  su -c 'apt install *.deb'
	  popd

	  su -c 'apt install -y python3-wither liblightdm-gobject-dev python3-gi'
	  git clone https://github.com/Antergos/web-greeter.git /tmp/greeter
	  pushd /tmp/greeter
	  su -c 'make install'
	  popd

	  su -c 'wget --content-disposition -P /usr/share/fonts/truetype/robotomono https://github.com/googlefonts/RobotoMono/tree/main/fonts/ttf/RobotoMono-{Bold,BoldItalic,Italic,Light,LightItalic,Medium,MediumItalic,Regular,Thin,ThinItalic}.ttf?raw=true
'
  	  sleep 3; clear
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
  su -c 'cp -r . /usr/share/'
  cd ../bin/
  su -c 'cp -r . /usr/bin/'
  su -c 'rm -rf ~/dotfiles/'

  su -c 'sed -i "s/#greeter-session.*/greeter-session=lightdm-webkit2-greeter/g" /etc/lightdm/lightdm.conf'
  su -c 'sed -i "s/webkit_theme.*/webkit_theme = minimal/g" /etc/lightdm/lightdm-webkit2-greeter.conf'
  su -c 'systemctl enable lightdm'

  cd ~
  chmod u+x .config/awesome/bin/*

  fc-cache -fv
  xrdb ~/.Xresources
  xdg-user-dirs-update
  mkdir ~/Pictures/Screenshots
  sleep 3; clear

  read -r -p "
Installation complete, thank you for using my dotfiles!
This script was made by Stardust-kyun and Reverse.
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
