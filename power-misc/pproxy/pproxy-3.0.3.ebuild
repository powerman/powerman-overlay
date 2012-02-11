# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="HTTP proxy with cache-only mode and ability to cache CGI"
HOMEPAGE="http://powerman.name/"
SRC_URI="http://powerman.name/download/pproxy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dosbin bin/pproxy
	insinto /usr/share/pproxy
	doins bin/PProxy.pm
	insinto /etc
	doins etc/pproxy.conf
	exeinto /etc/cron.daily
	doexe cron/pproxy-cleanup
	
	exeinto /service/pproxy
	doexe service/run
	exeinto /service/pproxy/log
	doexe service/log/run

	exeinto /usr/share/${P}/cgi
	doexe www/*.cgi
	insinto /usr/share/${P}/cgi/images
	doins www/images/*

	dodir /var/log/pproxy
	dodir /var/cache
	diropts -m0777
	dodir /var/cache/pproxy
}

