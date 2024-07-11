# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Catch-all log with most important data from all other logs"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="runit-service/setupservices"
RDEPEND=">=sys-process/runit-2.1.2-r1"

src_install() {
	cp -a * "${D}"
	for d in var/log/*/; do
		fowners log:root /"$d"
		fperms 0750 /"$d"
	done
	fperms 0600 /var/log/all/.log
}

pkg_postinst() {
	if [ ! -d "${ROOT}${SVDIR}"/notify ]; then
		ewarn "You MUST run service 'notify' at all runlevels where you use 'log-all'!"
		ewarn "Please run:	ln -s /etc/sv/notify ${ROOT}${SVDIR%/}/"
	fi
}
