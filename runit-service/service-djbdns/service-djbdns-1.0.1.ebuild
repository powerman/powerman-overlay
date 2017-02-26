# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="Service for net-dns/djbdns"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	net-dns/djbdns
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chown dnslog:root /var/log/axfrdns
	chmod 2750 /var/log/axfrdns
	chown dnslog:root /var/log/axfrdns/all
	chmod 2755 /var/log/axfrdns/all
	chown dnslog:root /var/log/dnscache
	chmod 2750 /var/log/dnscache
	chown dnslog:root /var/log/dnscache/all
	chmod 2755 /var/log/dnscache/all
	chown dnslog:root /var/log/tinydns
	chmod 2750 /var/log/tinydns
	chown dnslog:root /var/log/tinydns/all
	chmod 2755 /var/log/tinydns/all
	chown dnslog:root /var/log/axfrdns/*/{lock,state,newstate,current} 2>/dev/null
	chown dnslog:root /var/log/dnscache/*/{lock,state,newstate,current} 2>/dev/null
	chown dnslog:root /var/log/tinydns/*/{lock,state,newstate,current} 2>/dev/null

	if [ -d /service/dnscachex ]; then
		ewarn "Possible old version of this service detected: /service/dnscachex"
	fi

	for d in /service/tinydns-*; do
		[ -d "$d" ] && ewarn "Modified service may need update: $d"
	done
}
