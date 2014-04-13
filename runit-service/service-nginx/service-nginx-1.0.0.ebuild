# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Service for www-servers/nginx"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	www-servers/nginx
	"

src_install() {
	cp -a * "${D}"
}

pkg_preinst() {
	if [ -f /var/log/nginx/access_log ]; then
		mv /var/log/nginx/access_log  /var/log/nginx/access_log.old
		mv /var/log/nginx/error_log   /var/log/nginx/error_log.old
		ewarn "You current logs was renamed to /var/log/nginx/{access,error}_log.old."
		ewarn "You should start new services now and restart nginx:"
		ewarn "    ln -s /service/nginx-log-access  /var/service/"
		ewarn "    ln -s /service/nginx-log-error   /var/service/"
		ewarn "    sv t nginx"
	fi
}

pkg_postinst() {
	chown log:root /var/log/nginx
	chmod 2750 /var/log/nginx
	chown log:root /var/log/nginx/access
	chmod 2750 /var/log/nginx/access
	chown log:root /var/log/nginx/error
	chmod 2750 /var/log/nginx/error
	chmod 600 /var/log/nginx/access_log
	chmod 600 /var/log/nginx/error_log
	chown log:root /var/log/nginx/*/{lock,state,newstate,current} 2>/dev/null
}

