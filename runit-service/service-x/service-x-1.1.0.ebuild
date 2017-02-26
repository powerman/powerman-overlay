# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="Service for x11-base/xorg-x11"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	runit-service/service-agetty
	runit-service/service-dbus
	runit-service/service-consolekit
	x11-apps/xinit
	x11-misc/slim
	"

src_install() {
	cp -a * "${D}"
}
