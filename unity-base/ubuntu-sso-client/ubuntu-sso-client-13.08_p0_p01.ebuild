# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 eutils ubuntu-versionator

UURL="mirror://ubuntu/pool/main/u/${PN}"
URELEASE="saucy"

DESCRIPTION="Ubuntu Single Sign-On client for the Unity desktop"
HOMEPAGE="https://launchpad.net/ubuntu-sso-client"
SRC_URI="${UURL}/${MY_P}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
#KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=">=dev-libs/glib-2.32.3
	dev-python/configglue[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/gnome-keyring-python
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/imaging[${PYTHON_USEDEP}]
	dev-python/notify-python[${PYTHON_USEDEP}]
	>=dev-python/oauth-1.0[${PYTHON_USEDEP}]
	dev-python/PyQt4[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	>=dev-python/python-distutils-extra-2.37[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/simplejson[${PYTHON_USEDEP}]
	>=dev-python/twisted-names-12.2.0[${PYTHON_USEDEP}]
	>=dev-python/twisted-web-12.2.0[${PYTHON_USEDEP}]
	net-libs/libsoup"
DEPEND="${RDEPEND}"

src_install() {
	distutils-r1_src_install
	python_fix_shebang "${ED}"
}
