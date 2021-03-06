# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lightdm-kde/lightdm-kde-0.3.1.ebuild,v 1.6 2013/05/09 15:48:07 maekke Exp $

EAPI=5


KDE_MINIMAL="4.8"
KDE_SCM="git"
EGIT_REPONAME="${PN/-kde/}"
KDE_LINGUAS="cs da de el es et fi fr ga hu it ja km lt nds nl pl pt pt_BR ro sk sv uk"
inherit kde4-base ubuntu-versionator

UURL="https://launchpad.net/ubuntu/saucy/+source/${PN}/${PV}-${UVER}/+files"
URELEASE="saucy"

DESCRIPTION="LightDM KDE greeter patched for unity desktop"
HOMEPAGE="https://launchpad.net/lightdm"
SRC_URI="${UURL}/${MY_P}.orig.tar.bz2
        ${UURL}/${MY_P}${UVER_PREFIX}-${UVER}.debian.tar.gz"

LICENSE="GPL-3"
#KEYWORDS="amd64 ~arm ~ppc x86"
SLOT="4"
IUSE="debug"

RESTRICT="mirror"

DEPEND="
	x11-libs/libX11
	dev-qt/qtdeclarative:4
	>=x11-misc/lightdm-1.3.2[qt4]
	kde-base/kdelibs:4
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN/-kde}-${PV}

pkg_pretend() {
        if [[ $(gcc-major-version) -lt 4 ]] || \
                ( [[ $(gcc-major-version) -eq 4 && $(gcc-minor-version) -lt 7 ]] ) || \
                        ( [[ $(gcc-version) == "4.7" && $(gcc-micro-version) -lt 3 ]] ); then
                                die "${P} requires an active >=gcc-4.7.3, please consult the output of 'gcc-config -l'"
        fi
}

src_prepare() {
	for patch in $(cat "${WORKDIR}/debian/patches/series" | grep -v '#'); do
		PATCHES+=( "${WORKDIR}/debian/patches/${patch}" )
	done

	base_src_prepare
}
