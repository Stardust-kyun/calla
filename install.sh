#!/bin/env bash

#
# Start
#

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
else
  exit
fi

#
# Arch
#

if command -v pacman >/dev/null; then

update() {
cat << EOF

[ System Update ]

EOF

	sleep 3;
	su -c 'pacman -Syu --noconfirm'
	sleep 3; clear
}

sourcedeps() {
cat << EOF

[ Source Dependencies ]

EOF

	sleep 3;
	if ! command -v yay &> /dev/null; then
		su -c 'pacman -S git --noconfirm --needed'
		git clone https://aur.archlinux.org/yay.git /tmp/yay
		pushd /tmp/yay/
		makepkg -si --noconfirm --needed PKGBUILD
		popd
	else
		echo -e "\n(*) It seems that you already have yay installed, skipping..."
	fi
	sleep 3; clear
}

deps() {
cat << EOF

[ Dependencies ]

EOF

	sleep 3;
	yay -S base-devel xorg pipewire --needed --noconfirm
	yes | yay -S xclip xorg-xprop xdg-user-dirs awesome-git lightdm lightdm-webkit2-greeter light-locker rofi ttf-roboto \
	ttf-roboto-mono xsettingsd picom papirus-icon-theme xcursor-breeze inotify-tools light maim \
	polkit-gnome noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra --needed
	sleep 3; clear
}

#
# Debian
#

elif command -v dpkg >/dev/null; then

update() {
cat << EOF

[ System Update ]

EOF

	sleep 3;
	su -c 'apt update'
	sleep 3; clear
}

sourcedeps() {
cat << EOF

[ Source Dependencies ]

EOF

	sleep 3;

	su -c 'apt build-dep -y awesome'
	su -c 'apt install -y libxcb-xfixes0-dev'
	git clone https://github.com/awesomeWM/awesome /tmp/awesome-git
	pushd /tmp/awesome-git
	clear
	make package
	cd build
	su -c 'apt install ./*.deb'
	popd

	su -c 'apt install -y python3-wither liblightdm-gobject-dev python3-gi pyqt5-dev-tools zip curl'
	su -c 'echo "deb http://download.opensuse.org/repositories/home:/paulSUSE/Debian_11/ /" | tee /etc/apt/sources.list.d/home:paulSUSE.list'
	su -c 'curl -fsSL https://download.opensuse.org/repositories/home:paulSUSE/Debian_11/Release.key | gpg --dearmor | tee /etc/apt/trusted.gpg.d/home_paulSUSE.gpg > /dev/null'
	su -c 'apt update'

	su -c 'wget --content-disposition -P /usr/share/fonts/TTF https://github.com/googlefonts/RobotoMono/tree/main/fonts/ttf/RobotoMono-{Bold,BoldItalic,Italic,Light,LightItalic,Medium,MediumItalic,Regular,Thin,ThinItalic}.ttf?raw=true
'
	sleep 3; clear
}

deps() {
cat << EOF

[ Dependencies ]

EOF

	sleep 3;
	su -c 'apt install -y xclip xdg-user-dirs lightdm lightdm-webkit2-greeter light-locker rofi fonts-roboto \
	xsettingsd picom papirus-icon-theme breeze-cursor-theme inotify-tools light maim \
	policykit-1-gnome fonts-noto fonts-noto-cjk fonts-noto-color-emoji fonts-noto-cjk-extra'
	sleep 3; clear
}

#
# Fedora
#

elif command -v rpm >/dev/null; then

update() {
cat << EOF

[ System Update ]

EOF

	sleep 3;
	su -c 'dnf update -y'
	sleep 3; clear
}

sourcedeps() {
cat << EOF

[ Source Dependencies ]

EOF

	sleep 3;
	su -c 'dnf build-dep awesome -y'
	clear
	git clone https://github.com/awesomeWM/awesome /tmp/awesome-git 
	pushd /tmp/awesome-git
	make 
	su -c 'make install'
	popd
	sleep 3; clear
}

deps() {
cat << EOF

[ Dependencies ]

EOF

	sleep 3;
	su -c 'dnf install dnf-plugins-core -y'
	su -c 'dnf copr enable antergos/lightdm-webkit2-greeter -y'
	su -c 'dnf install --refresh xclip xprop xdg-user-dirs lightdm lightdm-webkit2-greeter light-locker \
	rofi google-roboto-fonts google-roboto-mono-fonts xsettingsd picom \
	breeze-cursor-theme inotify-tools light maim \
	polkit-gnome google-noto-cjk-fonts google-noto-fonts-common google-noto-emoji-fonts -y'
	sleep 3; clear
}

#
# Void
#

elif command -v xbps-install >/dev/null; then

update() {
cat << EOF

[ System Update ]

EOF

	sleep 3;
	su -c 'xbps-install -Syu'
	sleep 3; clear
}

sourcedeps() {
cat << EOF

[ Source Dependencies ]

EOF

	sleep 3;

	su -c 'xbps-install -Sy base-devel wget cmake ruby-asciidoctor ImageMagick pkg-config libxcb-devel pango-devel xcb-util-devel xcb-util-image-devel \
xcb-util-keysyms-devel xcb-util-wm-devel xcb-util-cursor-devel startup-notification-devel libxdg-basedir-devel \
gdk-pixbuf-devel dbus-devel libxkbcommon-devel xcb-util-xrm-devel dbus-x11 pango pango-devel lua53 lua53-devel lua53-lgi lua52-lgi lua54-lgi'
	git clone https://github.com/awesomeWM/awesome /tmp/awesome-git 
	pushd /tmp/awesome-git
	make 
	su -c 'make install'
	popd
	su -c 'mkdir /usr/share/xsessions'
	su -c 'mv /usr/local/share/xsessions/awesome.desktop /usr/share/xsessions/'

	wget https://fonts.google.com/download?family=Roboto%20Mono -P /tmp/roboto-mono
	pushd /tmp/roboto-mono
	unzip 'download?family=Roboto Mono'
	su -c 'cp static/* /usr/share/fonts/TTF/'
	popd

	sleep 3; clear
}

deps() {
cat << EOF

[ Dependencies ]

EOF

	sleep 3;
	su -c 'xbps-install -Sy \
	xclip xprop xdg-user-dirs lightdm lightdm-webkit2-greeter light-locker \
	rofi fonts-roboto-ttf xsettingsd xrdb elogind xorg unzip \
	picom breeze-cursors inotify-tools light maim pipewire alsa-pipewire wireplumber \
	polkit-gnome noto-fonts-ttf noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf-extra'
	sleep 3; clear
}

#
# Gentoo
#

elif command -v emerge >/dev/null; then

update() {
cat << EOF

[ System Update ]

EOF

	sleep 3;
	su -c 'emerge --sync'
	su -c 'emerge -uDU @world'
	sleep 3; clear
}

sourcedeps() {
cat << EOF

[ Source Dependencies ]

EOF

	sleep 3;
	if [ ! -d '/var/db/pkg/app-eselect/eselect-repository-12' ]; then
		su -c 'emerge app-eselect/eselect-repository-12 dev-util/pkgdev'
	fi
	su -c 'eselect repository create stardust-kyun'
	su -c 'mkdir -p /var/db/repos/stardust-kyun/x11-misc/lightdm-webkit2-greeter'
	su -c 'cp src/lightdm-webkit2-greeter-2.2.5.ebuild /var/db/repos/stardust-kyun/x11-misc/lightdm-webkit2-greeter'
	su -c 'chown -R portage:portage /var/db/repos/stardust-kyun'
	cd /var/db/repos/stardust-kyun/x11-misc/lightdm-webkit2-greeter
	su -c 'pkgdev manifest' && cd -
	if [ ! -f '/etc/portage/package.accept_keywords/awesome' ]; then
		su -c 'echo 'x11-wm/awesome **' >> /etc/portage/package.accept_keywords/awesome'
	fi
	if [ ! -f '/etc/portage/package.accept_keywords/light-locker' ]; then
		su -c 'echo 'x11-misc/light-locker ~amd64' >> /etc/portage/package.accept_keywords/light-locker'
	fi
	if [ ! -f '/etc/portage/package.use/kconfig' ]; then
		su -c 'echo 'kde-frameworks/kconfig qml' >> /etc/portage/package.use/kconfig'
	fi
	if [ ! -f '/etc/portage/package.use/kitemmodels' ]; then
		su -c 'echo 'kde-frameworks/kitemmodels qml' >> /etc/portage/package.use/kitemmodels'
	fi
	if [ ! -f '/etc/portage/package.use/lightdm' ]; then
		su -c 'echo 'x11-misc/lightdm non-root' >> /etc/portage/package.use/lightdm'
	fi
	sleep 3; clear
}

deps() {
cat << EOF

[ Dependencies ]

EOF

	sleep 3;
	su -c 'emerge x11-misc/xclip x11-apps/xprop x11-misc/lightdm-webkit2-greeter x11-misc/xdg-user-dirs x11-wm/awesome x11-misc/lightdm x11-misc/light-locker x11-misc/rofi media-fonts/roboto \
	x11-misc/xsettingsd x11-misc/picom x11-themes/papirus-icon-theme kde-plasma/breeze sys-fs/inotify-tools dev-libs/light media-gfx/maim \
	gnome-extra/polkit-gnome media-fonts/noto media-fonts/noto-cjk media-fonts/noto-emoji'
	sleep 3; clear
}

#
# OpenSUSE
#

elif command -v zypper >/dev/null; then

update() {
cat << EOF

[ System Update ]

EOF

	sleep 3;
	su -c 'zypper dup -y'
	sleep 3; clear
}

sourcedeps() {
cat << EOF

[ Source Dependencies ]

EOF

	sleep 3;
	su -c 'zypper mr -e 8'
	su -c 'zypper si awesome'
	git clone https://github.com/awesomeWM/awesome /tmp/awesome-git 
	pushd /tmp/awesome-git
	make 
	su -c 'make install'
	popd
	sleep 3; clear
}

deps() {
cat << EOF

[ Dependencies ]

EOF

	sleep 3;
	su -c 'zypper install xclip xprop xdg-user-dirs lightdm light-locker \
	rofi google-roboto-fonts google-roboto-mono-fonts xsettingsd picom \
	breeze5-cursors inotify-tools light maim \
	polkit-gnome noto* -y'
	sleep 3; clear
}

#
# Alpine
#

elif command -v apk >/dev/null; then

update() {
cat << EOF

[ System Update ]

EOF

	sleep 3;
	su -c 'apk upgrade -y'
	sleep 3; clear
}

sourcedeps() {
cat << EOF

[ Source Dependencies ]

EOF

	sleep 3;
	su -c 'apk add cairo-dev cmake dbus-dev gdk-pixbuf-dev glib-dev gperf imlib2-dev libev-dev libxcb-dev libxdg-basedir-dev libxkbcommon-dev lua-doc lua5.1-dev pango-dev samurai startup-notification-dev xcb-util-cursor-dev xcb-util-dev xcb-util-image-dev xcb-util-keysyms-dev xcb-util-wm-dev xcb-util-xrm-dev lua5.1-lgi'
	git clone https://github.com/awesomeWM/awesome /tmp/awesome-git 
	pushd /tmp/awesome-git
	make 
	su -c 'make install'
	popd
	sleep 3; clear
}

deps() {
cat << EOF

[ Dependencies ]

EOF

	sleep 3;
	su -c 'apk add alpine-base'
	su -c 'setup-xorg-base'
	su -c 'apk add xf86-input-mouse xf86-input-synaptics af86-input-evdev libinput'
	su -c 'rc-update add dbus'
	su -c 'rc-update add udev'
	su -c 'apk add xclip xprop xdg-user-dirs lightdm light-locker \
	rofi font-roboto font-roboto-mono xsettingsd picom \
	breeze breeze-icons inotify-tools light maim \
	polkit-gnome font-noto-cjk font-noto-cjk-extra font-noto-emoji -y'
	sleep 3; clear
}

fi

#
# Setup
#

setup() {

	sleep 3;
	
	echo "Copying files, please wait.."

	pushd ~/dotfiles
	cp -r home/. ~/
	su -c 'cp -r usr/share/* /usr/share/'
	su -c 'cp -r usr/bin/* /usr/bin/'
	popd

	su -c 'sed -i "s/#greeter-session.*/greeter-session=lightdm-webkit2-greeter/g" /etc/lightdm/lightdm.conf'
	su -c 'sed -i "s/webkit_theme.*/webkit_theme = greeter/g" /etc/lightdm/lightdm-webkit2-greeter.conf'
	if test -f /usr/local/share/xsessions/awesome.desktop; then
		su -c 'mv /usr/local/share/xsessions/awesome.desktop /usr/share/xsessions/awesome.desktop'
	fi

	if command -v systemctl >/dev/null; then
		su -c 'systemctl enable lightdm'
	elif command -v sv >/dev/null; then
		su -c 'touch /etc/sv/lightdm/down'
		su -c 'ln -s /etc/sv/lightdm /var/service'
	elif command -v rc-update >/dev/null; then
		su -c 'rc-update add lightdm'
	fi

	if command -v loginctl >/dev/null; then
		su -c 'ln -s /etc/sv/dbus /var/service'
	fi

	chmod u+x ~/.config/awesome/bin/*
	fc-cache -fv
	xrdb ~/.Xresources
	xdg-user-dirs-update
	mkdir ~/Pictures/Screenshots

	sleep 3; clear

}

#
# Run!
#

update
sourcedeps
deps
setup

#
# End
#

read -r -p "
Installation complete, thank you for using my dotfiles!

This script was made by Stardust-kyun, AloneERO,
Frankfut, Alyssa, Qwickdom, and Reverse.

Would you like to reboot?

(1) yes
(*) no

(?) Select option: " rbt

if [[ $rbt -eq 1 ]]; then
	sleep 3; clear
	if command -v systemctl >/dev/null; then
		systemctl reboot
	else
		if test -f /var/service/lightdm/down; then
			su -c 'rm /var/service/lightdm/down'
		fi
		su -c 'loginctl reboot'
	fi
else
	echo -e "\nSkipping..."
	sleep 3; clear
fi
