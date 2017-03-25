# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Watchdogs for system monitoring"
HOMEPAGE="http://powerman.name/soft/"
SRC_URI="http://powerman.name/download/powerwatchdog/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/mta
	|| ( sys-process/procps[-modern-top] app-admin/sysstat )"

src_install() {
	dosbin sbin/watchdog-check-{cpu,df,loadavg,mem,ping,proc,url}
	dosbin sbin/watchdog-report
	dodir /var/watchdog
}
