# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Service for net-misc/dhcp"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	net-misc/socat
	net-misc/dhcp
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chown nobody:nobody /service/dhcpd/root/var/run/dhcp/
	chown nobody:nobody /service/dhcpd/root/var/lib/dhcp/
}

