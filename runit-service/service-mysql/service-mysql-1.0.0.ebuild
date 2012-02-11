# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Service for dev-db/mysql"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	dev-db/mysql
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chmod 700 /service/mysql/run

	chown log:root /var/log/mysql
	chmod 2750 /var/log/mysql
	chown log:root /var/log/mysql/all
	chmod 2755 /var/log/mysql/all
	chown log:root /var/log/mysql/*/{lock,state,newstate,current} 2>/dev/null

	if [ -d /service/mysql-log ]; then
		ewarn "Old version of this service detected: /service/mysql-log"
	fi

	logs=$( egrep '^\s*(err-log|log-error)' /etc/mysql/my.cnf | 
		sed 's,.*=\s*,,' | sort -u );
	if [ "$logs" != "/dev/stdout" ]; then
		ewarn "Please configure mysql logs to stdout. Example:"
		ewarn "    [mysqld_safe]"
		ewarn "    err-log    = /dev/stdout"
		ewarn "    [mysqld]"
		ewarn "    log-error  = /dev/stdout"
	fi
}

