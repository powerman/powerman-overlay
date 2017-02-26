# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="Catch-all log with most important data from all other logs"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="runit-service/service-notify"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chmod 600 /var/log/all/.log

	chown log:root /var/log/all
	chmod 2750 /var/log/all
	chown log:root /var/log/all/{lock,state,newstate,current} 2>/dev/null

	if [ "$(readlink -f /var/service/notify)" != "/service/notify" ]; then
		ewarn "You MUST run service 'notify' at all runlevels where you use 'log-all'!"
		ewarn "Please run:	ln -nsf /service/notify /var/service/notify"
	fi
}
