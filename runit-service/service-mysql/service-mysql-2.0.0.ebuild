# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Service for dev-db/mysql"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="runit-service/setupservices"
RDEPEND=">=sys-process/runit-2.1.2-r1
	dev-db/mysql"

src_install() {
	cp -a * "${D}"
	for d in var/log/*/{,*/}; do
		fowners log:root /"$d"
		fperms 0750 /"$d"
	done
}

pkg_postinst() {
	if [ -d "${ROOT}"etc/sv/mysql-log ]; then
		ewarn "Old version of this service detected: ${ROOT}etc/sv/mysql-log"
	fi

	if [ "$(readlink /var/log/mysql/mysqld.err)" != "/dev/stdout" ] ||
		[ "$(readlink /var/log/mysql/mysql.err)" != "/dev/stdout" ]; then
		ewarn "Please configure mysql logs to stdout:"
		ewarn
		ewarn "    ln -snf /dev/stdout /var/log/mysql/mysql.err"
		ewarn "    ln -snf /dev/stdout /var/log/mysql/mysqld.err"
		ewarn
		ewarn "    [mysqld_safe]"
		ewarn "    err-log    = /var/log/mysql/mysql.err"
		ewarn "    [mysqld]"
		ewarn "    log-error  = /var/log/mysql/mysqld.err"
	fi
}
