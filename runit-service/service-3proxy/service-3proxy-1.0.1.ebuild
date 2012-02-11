# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Service for net-proxy/3proxy"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	net-proxy/3proxy
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chown nobody:root /service/3proxy/root/etc/3proxy.cfg
	chmod 400 /service/3proxy/root/etc/3proxy.cfg

	chown log:root /var/log/3proxy
	chmod 2750 /var/log/3proxy
	chown log:root /var/log/3proxy/all
	chmod 2755 /var/log/3proxy/all
	chown log:root /var/log/3proxy/*/{lock,state,newstate,current} 2>/dev/null

	for d in /service/3proxy-*; do
		[ -d "$d" ] && ewarn "Modified service may need update: $d"
	done
}

