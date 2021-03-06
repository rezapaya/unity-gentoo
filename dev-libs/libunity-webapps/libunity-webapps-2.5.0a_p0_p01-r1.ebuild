# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2 ubuntu-versionator

UURL="mirror://ubuntu/pool/main/libu/${PN}"
URELEASE="saucy"
UVER_PREFIX="~+13.10.20130828"

DESCRIPTION="Webapps integration with the Unity desktop"
HOMEPAGE="https://launchpad.net/libunity-webapps"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0/0.0.0"
#KEYWORDS="~amd64 ~x86"
IUSE="doc"
RESTRICT="mirror"

RDEPEND="dev-libs/libdbusmenu:=
	dev-libs/libunity:="
DEPEND="${RDEPEND}
	app-misc/geoclue
	dev-db/sqlite:3
	>=dev-libs/glib-2.32.3:2
	dev-libs/gobject-introspection
	dev-libs/json-glib
	dev-libs/libindicate[gtk,introspection]
	dev-util/intltool
	net-libs/libsoup
	net-libs/telepathy-glib
	x11-libs/gtk+:3
	unity-indicators/indicator-messages
	x11-libs/libnotify
	x11-libs/libwnck:3
	app-admin/packagekit"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		--disable-static \
		--libexecdir=/usr/lib/libunity-webapps
}

src_install() {
	gnome2_src_install

	# Remove all installed language files as they can be incomplete #
	#  due to being provided by Ubuntu's language-pack packages #
	rm -rf "${ED}usr/share/locale"
}

pkg_postinst() {
	elog
	elog "Unity webapps will only currently work if your default browser"
	elog "is set to either Firefox or Chromium"
	elog
}
