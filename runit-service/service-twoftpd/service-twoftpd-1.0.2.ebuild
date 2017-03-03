# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Service for net-ftp/twoftpd"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	net-ftp/twoftpd
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chmod 600 /service/twoftpd/passwd

	chown log:root /var/log/twoftpd
	chmod 2750 /var/log/twoftpd
	chown log:root /var/log/twoftpd/all
	chmod 2755 /var/log/twoftpd/all
	chown log:root /var/log/twoftpd/auth
	chmod 2755 /var/log/twoftpd/auth
	chown log:root /var/log/twoftpd/xfer
	chmod 2755 /var/log/twoftpd/xfer
	chown log:root /var/log/twoftpd/*/{lock,state,newstate,current} 2>/dev/null
}
