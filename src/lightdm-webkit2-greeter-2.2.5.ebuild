# Copyright 1999-2022 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

GITHUB_REPO="web-greeter"
GITHUB_USER="Antergos"
GITHUB_TAG="${PV/_/}"

DESCRIPTION="Webkit-based greeter for LightDM"
HOMEPAGE="https://github.com/Antergos/web-greeter"
SRC_URI="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/archive/${GITHUB_TAG}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE=""

BDEPEND="
	virtual/pkgconfig
	>=x11-misc/lightdm-1.19.2[gtk,introspection,non-root]
	net-libs/webkit-gtk
"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/gobject-introspection
	>=x11-libs/gtk+-3.22:3
	>=x11-misc/lightdm-1.19.2[gtk,introspection,non-root]
	>=net-libs/webkit-gtk-2.16
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${GITHUB_REPO}-${GITHUB_TAG}"



src_configure() {
	BUILD_DIR="${S}/build"
	meson_src_configure
}

src_install() {
	meson_src_install
}

