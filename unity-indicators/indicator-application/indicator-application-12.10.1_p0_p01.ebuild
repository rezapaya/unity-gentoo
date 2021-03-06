# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils flag-o-matic ubuntu-versionator

UURL="mirror://ubuntu/pool/main/i/${PN}"
URELEASE="raring"
UVER_PREFIX="daily13.01.25"

DESCRIPTION="Application indicators used by the Unity desktop"
HOMEPAGE="https://launchpad.net/indicator-application"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-libs/libappindicator:="
DEPEND="${RDEPEND}
	dev-libs/libdbusmenu
	dev-libs/libindicate-qt"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"

src_prepare() {
	eautoreconf
	append-cflags -Wno-error
}

src_install() {
	emake DESTDIR="${D}" install
	prune_libtool_files --modules
}
