# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="Service for sys-power/nut"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	sys-power/nut
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chown log:root /var/log/{upsd,upsmon}
	chmod 2750 /var/log/{upsd,upsmon}
	chown log:root /var/log/{upsd,upsmon}/all
	chown log:root /var/log/{upsd,upsmon}/*/{lock,state,newstate,current} 2>/dev/null
}
