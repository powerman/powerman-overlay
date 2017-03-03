# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Service for net-dialup/rp-pppoe"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	net-dialup/rp-pppoe
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chown log:root /var/log/adsl
	chmod 2750 /var/log/adsl
	chown log:root /var/log/adsl/all
	chmod 2755 /var/log/adsl/all
	chown log:root /var/log/adsl/stat
	chmod 2755 /var/log/adsl/stat
	chown log:root /var/log/adsl/*/{lock,state,newstate,current} 2>/dev/null

	for d in /service/adsl-*; do
		[ -d "$d" ] && ewarn "Modified service may need update: $d"
	done
}
