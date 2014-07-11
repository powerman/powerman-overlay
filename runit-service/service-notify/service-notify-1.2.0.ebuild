# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Process system log on-the-fly, detect events and run actions"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="runit-service/setupservices"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chmod 0600 /var/log/.notify

	if [ -d /service/log-notify ]; then
		ewarn "Possible old version of this service detected: /service/log-notify"
	fi
}

