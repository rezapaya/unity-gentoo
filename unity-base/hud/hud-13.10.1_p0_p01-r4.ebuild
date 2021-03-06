# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

GNOME2_LA_PUNT="yes"
VALA_MIN_API_VERSION="0.20"
VALA_USE_DEPEND="vapigen"

inherit cmake-utils distutils-r1 flag-o-matic ubuntu-versionator vala

UURL="mirror://ubuntu/pool/main/h/${PN}"
URELEASE="saucy"
UVER_PREFIX="+13.10.20130822.4"

DESCRIPTION="Backend for the Unity HUD"
HOMEPAGE="https://launchpad.net/hud"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="mirror"

RDEPEND="dev-libs/libdbusmenu:=
	unity-base/bamf:="
DEPEND="${RDEPEND}
	dev-db/sqlite:3
	dev-libs/dee[${PYTHON_USEDEP}]
	>=dev-libs/glib-2.35.4[${PYTHON_USEDEP}]
	dev-perl/XML-Parser
	gnome-base/dconf
	x11-libs/gtk+:3
	x11-libs/pango
	app-accessibility/pocketsphinx[${PYTHON_USEDEP}]
	$(vala_depend)
	test? ( dev-util/dbus-test-runner )"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"

src_prepare() {
	vala_src_prepare

	# Stop cmake doing the job of distutils #
	sed -e '/add_subdirectory(hudkeywords)/d' \
		-i tools/CMakeLists.txt	
}

src_configure() {
	local mycmakeargs="${mycmakeargs}
			$(cmake-utils_use_enable test TESTS)
			-DVALA_COMPILER=$(type -P valac-0.20)
			-DVAPI_GEN=$(type -P vapigen-0.20)
			-DCMAKE_INSTALL_DATADIR=/usr/share"
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	pushd tools/hudkeywords
		distutils-r1_src_compile
	popd
}

src_install() {
	cmake-utils_src_install
	pushd tools/hudkeywords
		distutils-r1_src_install
		python_fix_shebang "${ED}"
	popd

	# Remove upstart jobs as we use xsession based scripts in /etc/X11/xinit/xinitrc.d/ #
	# /usr/libexec/hud/hud-service is started by dbus anyway, so only needed for lack of dbus support in upstart #
	rm -rf "${ED}usr/share/upstart"
}
