#!/bin/env bash

step_1(){
cat << EOF

[ Step 1 ] System Update

EOF

  sleep 3;
  echo "Updating worldset, this may take a while.."
  su -c'emerge --sync'
  su -c'emerge -uDU @world'
  clear
}

step_2(){
cat << EOF

[ Step 2 ] Librewolf, Awesome, and Lightdm Setup

EOF

  sleep 3;
  if [ ! -d '/var/db/pkg/app-eselect/eselect-repository-12' ]; then
  	su -c'emerge app-eselect/eselect-repository-12 dev-util/pkgdev'
  fi
  su -c'eselect repository create stardust-kyun'
  su -c'mkdir -p /var/db/repos/stardust-kyun/x11-misc/lightdm-webkit2-greeter'
  su -c'cp src/lightdm-webkit2-greeter-2.2.5.ebuild /var/db/repos/stardust-kyun/x11-misc/lightdm-webkit2-greeter'
  su -c'chown -R portage:portage /var/db/repos/stardust-kyun'
  cd /var/db/repos/stardust-kyun/x11-misc/lightdm-webkit2-greeter
  su -c'pkgdev manifest' && cd -
  if [ ! -d '/var/db/repos/librewolf' ]; then
      su -c'eselect repository add librewolf git https://gitlab.com/librewolf-community/browser/gentoo.git'
  fi
  su -c'emaint -r librewolf sync'
  if [ ! -f '/etc/portage/package.accept_keywords/awesome' ]; then
  	su -c"echo 'x11-wm/awesome **' >> /etc/portage/package.accept_keywords/awesome"
  fi
  if [ ! -f '/etc/portage/package.accept_keywords/light-locker' ]; then
  	su -c"echo 'x11-misc/light-locker ~amd64' >> /etc/portage/package.accept_keywords/light-locker"
  fi
  if [ ! -f '/etc/portage/package.use/kconfig' ]; then
  	su -c"echo 'kde-frameworks/kconfig qml' >> /etc/portage/package.use/kconfig"
  fi
  if [ ! -f '/etc/portage/package.use/kitemmodels' ]; then
  	su -c"echo 'kde-frameworks/kitemmodels qml' >> /etc/portage/package.use/kitemmodels"
  fi
  if [ ! -f '/etc/portage/package.use/lightdm' ]; then
  	su -c"echo 'x11-misc/lightdm non-root' >> /etc/portage/package.use/lightdm"
  fi
  clear
}

step_3(){
cat << EOF


[ Step 3 ] Dependencies

(1) Full installation: Includes my preferred programs and utilities
(2) Minimal installation: Base system only

EOF

  read -p "(?) Select option: " ans_3
  if [[ $ans_3 == "1" ]]; then
	sleep 3; clear
      su -c'emerge app-editors/gvim x11-misc/lightdm-webkit2-greeter x11-apps/xprop x11-misc/light-locker x11-misc/xclip x11-misc/xdg-user-dirs x11-misc/lightdm x11-wm/awesome www-client/librewolf-bin gnome-extra/nemo media-libs/gd x11-misc/rofi media-fonts/roboto \
      x11-misc/xsettingsd x11-misc/picom gnome-extra/nm-applet x11-misc/cbatticon media-sound/volumeicon x11-themes/papirus-icon-theme kde-plasma/breeze sys-fs/inotify-tools dev-libs/light media-gfx/maim app-text/zathura-meta \
      media-gfx/viewnior gnome-extra/polkit-gnome media-fonts/noto media-fonts/noto-cjk media-fonts/noto-emoji' 
    sleep 3; clear
    
  elif [[ $ans_3 == "2" ]]; then
	sleep 3; clear
      su -c'emerge x11-misc/xclip x11-apps/xprop x11-misc/lightdm-webkit2-greeter x11-misc/xdg-user-dirs x11-wm/awesome x11-misc/lightdm x11-misc/light-locker x11-misc/rofi media-fonts/roboto \
      x11-misc/xsettingsd x11-misc/picom x11-themes/papirus-icon-theme kde-plasma/breeze sys-fs/inotify-tools dev-libs/light media-gfx/maim \
      gnome-extra/polkit-gnome media-fonts/noto media-fonts/noto-cjk media-fonts/noto-emoji'
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
  su -c'cp -r . /usr/share/'
  cd ../bin/
  su -c'cp -r . /usr/bin/' 
  cd ../../lib/librewolf/
  sed -i "s/USER/`whoami`/g" mozilla.cfg
  su -c'cp -r . /lib/librewolf/'
  su -c'rm -rf ~/dotfiles/'

  su -c'sed -i "s/#greeter-session.*/greeter-session=lightdm-webkit2-greeter/g" /etc/lightdm/lightdm.conf'
  su -c'sed -i "s/webkit_theme.*/webkit_theme = minimal/g" /etc/lightdm/lightdm-webkit2-greeter.conf'
  if command -v rc-update &> /dev/null; then
  	su -c'rc-update add lightdm' && su -c'rc-update add NetworkManager'
  else
  	su -c'systemctl enable lightdm' && su -c'systemctl enable NetworkManager'
  fi
  cd ~
  chmod u+x .config/awesome/bin/*

  cd ~/.config/st
  su -c'make install'

  fc-cache -fv
  xrdb ~/.Xresources
  xdg-user-dirs-update
  mkdir ~/Pictures/Screenshots
  sleep 3; clear

  read -r -p "
Installation complete, thank you for using my dotfiles!
This script was made by Alyssa.
Would you like to reboot?

(1) yes
(*) no

(?) Select option: " rbt
  if [[ $rbt -eq 1 ]]; then
  sleep 3; clear
	if command -v loginctl &> /dev/null; then
		loginctl reboot
	else
		systemctl reboot
	fi
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
