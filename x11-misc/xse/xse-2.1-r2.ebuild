# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="Command Line Interface to XSendEvent()"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="https://github.com/epitron/xse/archive/v${PV}-patched.tar.gz -> ${P}-patched.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libbsd
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXaw
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/libXt
	x11-libs/libxcb"
DEPEND="${RDEPEND}
	x11-misc/gccmakedep
	x11-misc/imake"

S="${WORKDIR}/${P}-patched"

src_configure() {
	xmkmf -a || die
	default
}

src_compile() {
	emake CCOPTIONS="$CFLAGS" LOCAL_LDFLAGS="$LDFLAGS"
}

src_install() {
	dobin xse

	insinto /usr/share/X11/app-defaults
	newins Xse.ad Xse

	newman xse.man xse.1
	einstalldocs
}
