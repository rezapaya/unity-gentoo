# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
VALA_MIN_API_VERSION="0.20"
VALA_USE_DEPEND="vapigen"

inherit autotools eutils ubuntu-versionator vala

UURL="mirror://ubuntu/pool/main/u/${PN}"
URELEASE="saucy"
UVER_PREFIX="daily13.06.21"

DESCRIPTION="Music lens for the Unity desktop"
HOMEPAGE="https://launchpad.net/unity-lens-music"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-libs/dee:=
	dev-libs/libunity:=
	unity-base/rhythmbox-ubuntuone"
DEPEND="dev-db/sqlite:3
	dev-libs/dee
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee
	>=dev-libs/libunity-7.0.0
	gnome-base/gnome-menus:3
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	net-libs/libsoup
	net-libs/libsoup-gnome
	net-libs/liboauth
	sys-libs/tdb
	>=unity-base/unity-7.1.0
	$(vala_depend)"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"

src_prepare() {
	vala_src_prepare
	export VALA_API_GEN="$VAPIGEN"
	eautoreconf
}
