# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Service for net-misc/openssh"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="runit-service/setupservices"
RDEPEND=">=sys-process/runit-2.1.2-r1
	net-misc/openssh"

src_install() {
	cp -a * "${D}"
}
