# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Service for net-mail/qpopper"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	net-mail/qpopper
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chown log:root /var/log/qpopper
	chmod 2750 /var/log/qpopper
	chown log:root /var/log/qpopper/all
	chmod 2755 /var/log/qpopper/all
	chown log:root /var/log/qpopper-ssl
	chmod 2750 /var/log/qpopper-ssl
	chown log:root /var/log/qpopper-ssl/all
	chmod 2755 /var/log/qpopper-ssl/all
	chown log:root /var/log/qpopper/*/{lock,state,newstate,current} 2>/dev/null
	chown log:root /var/log/qpopper-ssl/*/{lock,state,newstate,current} 2>/dev/null
}

