# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

inherit eutils

DESCRIPTION="Command Line Interface to XSendEvent()"
HOMEPAGE="ftp://ftp.x.org/R5contrib/"
SRC_URI="ftp://ftp.x.org/R5contrib/xsendevent-${PV}.tar.Z"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libXt
	x11-misc/gccmakedep
	app-text/rman
	x11-libs/libXaw
	x11-libs/libXp"
DEPEND="${RDEPEND}
	x11-misc/imake"

src_compile() {
	xmkmf -a &> /dev/null || die
	econf; emake CCOPTIONS="${CFLAGS}" LOCAL_LDFLAGS=${LDFLAGS} || die
}

src_install() {
	dobin xse

	newman xse.man xse.1
	dodoc README

	dodir /usr/share/X11/app-defaults
	insinto /usr/share/X11/app-defaults
	newins Xse.ad Xse
}
