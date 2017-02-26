# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="Service for app-emulation/docker"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	app-emulation/docker
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chown log:root /var/log/docker
	chmod 2750 /var/log/docker
	chown log:root /var/log/docker/all
	chown log:root /var/log/docker/*/{lock,state,newstate,current} 2>/dev/null
}
