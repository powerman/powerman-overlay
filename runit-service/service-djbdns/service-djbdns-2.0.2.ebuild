# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Service for net-dns/djbdns"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="runit-service/setupservices"
RDEPEND=">=sys-process/runit-2.1.2-r1
	net-dns/djbdns"

src_install() {
	cp -a * "${D}"
	for d in var/log/*/{,*/}; do
		fowners log:root /"$d"
		fperms 0750 /"$d"
	done
}

pkg_postinst() {
	for d in "${ROOT}"etc/sv/tinydns?*/; do
		[ -e "$d" ] && ewarn "Modified service may need update: $d"
	done
}
