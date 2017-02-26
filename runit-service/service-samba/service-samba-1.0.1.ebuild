# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="Service for net-fs/samba"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	net-fs/samba
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chown log:root /var/log/nmbd
	chmod 2750 /var/log/nmbd
	chown log:root /var/log/nmbd/all
	chmod 2755 /var/log/nmbd/all
	chown log:root /var/log/smbd
	chmod 2750 /var/log/smbd
	chown log:root /var/log/smbd/all
	chmod 2755 /var/log/smbd/all
	chown log:root /var/log/nmbd/*/{lock,state,newstate,current} 2>/dev/null
	chown log:root /var/log/smbd/*/{lock,state,newstate,current} 2>/dev/null
}
