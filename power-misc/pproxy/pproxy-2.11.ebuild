# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="HTTP proxy with cache-only mode and ability to cache CGI"
HOMEPAGE="http://powerman.name/"
SRC_URI="http://powerman.name/download/pproxy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	# compile included perl modules
	cd modules
	for archive in *.tar.gz; do
		module=$(echo $archive | sed s,.tar.gz$,,)
		tar xzvf $archive
		cd $module
		if [ -f Build.PL ]; then
			perl Build.PL install_base=/usr/share/${P} destdir=${D} && ./Build
		else
			perl Makefile.PL LIB=/usr/share/${P}/lib DESTDIR=${D} \
				INSTALLSITEMAN3DIR=/usr/share/${P}/man/man3 && make
		fi
		cd ..
	done
	cd ..
}

src_install() {
	# install perl modules in pproxy's private directory
	for module in $(find modules -type d -mindepth 1 -maxdepth 1); do
		cd $module
		if [ -f Build ]; then
			./Build install
		else
			make install
		fi
		cd ../..
	done
	
	# install other files & dirs
	dosbin bin/pproxy
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

