# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Service for sys-power/upsmon-usb"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	sys-power/upsmon-usb
	"

src_install() {
	cp -a * "${D}"
}

