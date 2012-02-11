# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Service for sys-power/acpid"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	sys-power/acpid
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chown log:root /var/log/acpid
	chmod 2750 /var/log/acpid
	chown log:root /var/log/acpid/all
	chown log:root /var/log/acpid/*/{lock,state,newstate,current} 2>/dev/null
}

