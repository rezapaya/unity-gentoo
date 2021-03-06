# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils gnome2 ubuntu-versionator

UURL="mirror://ubuntu/pool/main/u/${PN}"
URELEASE="raring"
UVER_PREFIX="daily13.04.24"

DESCRIPTION="Unity desktop icon theme"
HOMEPAGE="https://launchpad.net/unity-asset-pool"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=x11-themes/gnome-icon-theme-3.6
	x11-themes/hicolor-icon-theme"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.19
	>=sys-devel/gettext-0.15"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"

src_prepare() {
	:
}

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	insinto /usr/share/unity/themes
	doins -r launcher/* panel/*

	insinto /usr/share/icons
	doins -r unity-icon-theme
	doins -r unity-webapps-applications
	dosym /usr/share/icons/unity-webapps-applications/apps/128/amazon-store.png \
		/usr/share/icons/hicolor/128x128/apps/amazon-store.png
	dosym /usr/share/icons/unity-webapps-applications/apps/128/ubuntuone-music.png \
		/usr/share/icons/hicolor/128x128/apps/ubuntuone-music.png

	insinto /usr/share/icons/hicolor/32x32/apps
	doins account-plugins-icons/*

	dodoc COPYRIGHT
}
