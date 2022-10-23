#!/bin/env bash

clear
echo -e "Hello $USER! \n
To use this script your selections are whit numbers\n"

step_1(){
  echo -e "[ Step 1 ] System update\n"
  sudo pacman -Syu --noconfirm
  sleep 3; clear
}

step_2(){
cat << EOF

[ Step 2 ] Git and pacman wrapper

These are the popular:
(1) yay
(2) paru

EOF

  read -p "(?) Select option: " ans_2
  if [[ $ans_2 == "1" ]] || [[ $ans_2 == "yay" ]]; then
    HELPER="yay"
    if ! command -v $HELPER &> /dev/null; then
      sudo pacman -S git --noconfirm
      git clone https://aur.archlinux.org/$HELPER.git /tmp/$HELPER
      (cd /tmp/$HELPER/ && makepkg -si PKGBUILD)
      sleep 3; clear
    else
      echo -e "\n(*) It seems that you already have $HELPER installed, skipping..."
      sleep 3; clear
    fi
    
  elif [[ $ans_2 == "2" ]] || [[ $ans_2 == "paru" ]]; then
    HELPER="paru"
    if ! command -v $HELPER &> /dev/null; then
      sudo pacman -S git --noconfirm
      git clone https://aur.archlinux.org/$HELPER.git /tmp/$HELPER
      (cd /tmp/$HELPER/ && makepkg -si PKGBUILD)
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

  $HELPER -S awesome-git lightdm lightdm-webkit2-greeter gvim librewolf-bin nautilus gd rofi ttf-roboto \
  ttf-roboto-mono xsettingsd picom network-manager-applet xcursor-breeze inotify-tools light maim zathura \
  viewnior polkit-gnome --noconfirm
  sleep 3; clear
}

step_4(){
cat << EOF

[ Step 4 ] Get dotfiles

Cloning the repository...

EOF

  git clone https://github.com/Stardust-kyun/dotfiles /tmp/dotfiles
  cd /tmp/dotfiles/
  echo -e "\nDotfiles are ready to be copied"
  sleep 3; clear
}

step_5(){
cat << EOF

[ Step 5 ] Copy dotfiles

Now, I'll proceed to copy the dotfiles

EOF
  cd home/
  cp -rf .config .icons .librewolf .vim .Xresources .bashrc .gtkrc-2.0 .xsettingsd ~/
  cd ../usr/share/
  sudo cp -rf themes icons lightdm-webkit /usr/share/
  xrdb ~/.Xresources
  sudo cp fonts/TTF/* /usr/share/fonts/TTF/

  cd ~/.config/st
  sudo make install

  sudo sed -i 's/#greeter-session.*/greeter-session=lightdm-webkit2-greeter/g' /etc/lightdm/lightdm.conf
  sudo sed -i 's/webkit_theme.*/webkit_theme = minimal/g' /etc/lightdm/lightdm-webkit2-greeter.conf
  sudo systemctl enable lightdm
}

step_6(){
cat << EOF

[ Step 6 ] Enjoy!

Make some binaries executable

EOF

  cd ~
  chmod u+x .config/rofi/*
  chmod u+x .config/awesome/bin/*
  fc-cache -fv
  echo -e "\nAlright, it seems that everything is ready"
  sleep 3; clear
  echo "Thank you for using this script, I hope it has been useful to you"
  echo "Reboot the system?"
  echo "(1) yes   (2) no"
  read -r -p "(default 1): " rbt
  case $rbt in 
    [1])
      sys='systemctl reboot'
      ;;
    [2])
      sys='(*) Skipping... Really, why?'
      ;;
    [*])
      sys='systemctl reboot'
      ;;
  esac
  if [ $rbt -eq 1 ]; then
    sleep 3; clear
    echo "SEE YOU SPACE COWBOY..."
    $sys
  else
    echo -e "\n$sys"
    sleep 3; clear
    echo -e "ARE YOU LIVING IN THE \nREAL WORLD?"
    sleep 3; clear
  fi
}

sleep 3;
step_1

while [[ $ans_2 != "1" ]] && [[ $ans_2 != "2" ]] && [[ $ans_2 != "yay" ]] && [[ $ans_2 != "paru" ]]; do
  step_2
done

step_3
step_4
step_5
step_6
