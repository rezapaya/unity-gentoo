# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )

WANT_AUTOMAKE=1.12
VALA_MIN_API_VERSION="0.20"
VALA_USE_DEPEND="vapigen"

inherit vala autotools base eutils python-r1 ubuntu-versionator

UURL="mirror://ubuntu/pool/main/libs/${PN}"
URELEASE="saucy"
UVER_PREFIX="daily13.06.25"

DESCRIPTION="GObject introspection data for the Signon library for the Unity desktop"
HOMEPAGE="https://launchpad.net/libsignon-glib"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz
	 ${UURL}/${MY_P}${UVER_PREFIX}-${UVER}.diff.gz"

LICENSE="LGPL-3"
SLOT="0/1.0.0"
#KEYWORDS="~amd64 ~x86"
IUSE="debug"
RESTRICT="mirror"

S=${WORKDIR}/${PN}-${PV}${UVER_PREFIX}

RDEPEND="dev-libs/check
	>=dev-libs/glib-2.35.1
	>=dev-libs/gobject-introspection-1.36.0
	dev-util/gdbus-codegen
	unity-base/signon"
DEPEND="${RDEPEND}
	dev-util/gtk-doc
	dev-util/gtk-doc-am"

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	epatch -p1 "${WORKDIR}/${MY_P}${UVER_PREFIX}-${UVER}.diff" || die
	vala_src_prepare
	eautoreconf
}

src_configure() {
	econf $(use_enable debug) || die
}

src_compile() {
	emake || die
}

src_install() {
	rm -rf "${D}usr/doc"
	
	emake DESTDIR="${ED}" install
	prune_libtool_files --modules
}
