# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Service for agetty"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	sys-apps/util-linux
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	if [ -d /etc/runit/runsvdir/all/getty-tty1 ]; then
		ewarn "Old version of this service detected: /etc/runit/runsvdir/all/getty-*"
		ewarn "Please make sure you running services from /service/agetty-* instead!"
	fi
}

