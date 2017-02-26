# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Service for sys-process/dcron"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="runit-service/setupservices"
RDEPEND=">=sys-process/runit-2.1.2-r1
	sys-process/dcron"

src_install() {
	cp -a * "${D}"
	for d in var/log/*/; do
		fowners log:root /"$d"
		fperms 2750 /"$d"
	done
	for d in var/log/*/*/; do
		fowners log:root /"$d"
	done
}
