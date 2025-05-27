# From @levraiardox 
# To https://github.com/Stardust-kyun/calla

pkgname="calla"
pkgver="0.3"
pkgrel="1"
pkgdesc="Calla desktop environement"
arch=("x86_64")
url="https://github.com/Stardust-kyun/calla"

depends=(
        "xorg-server" 
        "pipewire-pulse"
        "brightnessctl"
        "inotify-tools"
        "awesome-git"
        "picom"
        "maim"
        "papirus-icon-theme"
        "noto-fonts"
        "noto-fonts-cjk"
        "noto-color-emoji-fontconfig"
        "noto-fonts-extra"
        "lua-pam-git"
        )

optdepends=(
        "st: terminal",
        "vim-gtk3: vim with clipboard",
        "nemo: file manager",
        "network-manager-gnome: network applet",
        "polkit-gnome: polkit",
        "cbatticon: battery applet",
        "blueman: bluetooth applet",
        "xdg-user-dirs: generate home directories",
        "lollypop: music player",
        )

package() {
    cp -r "${srcdir}/usr" "${pkgdir}/"
}
