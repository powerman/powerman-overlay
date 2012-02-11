# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Service for app-admin/socklog"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	>=app-admin/socklog-2.1.0
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chown log:root /var/log/socklog-inet
	chmod 2750 /var/log/socklog-inet
	chown log:root /var/log/socklog-inet/all
	chmod 2755 /var/log/socklog-inet/all
	chown log:root /var/log/socklog-klog
	chmod 2750 /var/log/socklog-klog
	chown log:root /var/log/socklog-klog/all
	chmod 2755 /var/log/socklog-klog/all
	chown log:root /var/log/socklog-klog/misc
	chmod 2755 /var/log/socklog-klog/misc
	chown log:root /var/log/socklog-klog/firewall
	chmod 2755 /var/log/socklog-klog/firewall
	chown log:root /var/log/socklog-unix
	chmod 2750 /var/log/socklog-unix
	chown log:root /var/log/socklog-unix/all
	chmod 2755 /var/log/socklog-unix/all
	chown log:root /var/log/socklog-unix/auth
	chmod 2755 /var/log/socklog-unix/auth
	chown log:root /var/log/socklog-unix/ppp-stat
	chmod 2755 /var/log/socklog-unix/ppp-stat
	chown log:root /var/log/socklog-inet/*/{lock,state,newstate,current} 2>/dev/null
	chown log:root /var/log/socklog-klog/*/{lock,state,newstate,current} 2>/dev/null
	chown log:root /var/log/socklog-unix/*/{lock,state,newstate,current} 2>/dev/null
}

