# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Service for www-servers/apache-2"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	>www-servers/apache-2
	"

src_install() {
	cp -a * "${D}"
}

pkg_preinst() {
	if [ -f /var/log/apache2/ssl_access_log ]; then
		mv /var/log/apache2/ssl_access_log  /var/log/apache2/ssl_access_log.old
		mv /var/log/apache2/ssl_error_log   /var/log/apache2/ssl_error_log.old
		mv /var/log/apache2/ssl_request_log /var/log/apache2/ssl_request_log.old
		ewarn "This package now contain 3 new services for ssl-logs."
		ewarn "You current logs was renamed to /var/log/apache2/ssl_*_log.old."
		ewarn "You should start new services now and restart apache:"
		ewarn "    ln -s /service/apache2-log-ssl-access  /var/service/"
		ewarn "    ln -s /service/apache2-log-ssl-error   /var/service/"
		ewarn "    ln -s /service/apache2-log-ssl-request /var/service/"
		ewarn "    sv t apache2"
	fi
}

pkg_postinst() {
	chown log:root /var/log/apache2
	chmod 2750 /var/log/apache2
	chown log:root /var/log/apache2/access
	chmod 2750 /var/log/apache2/access
	chown log:root /var/log/apache2/error
	chmod 2750 /var/log/apache2/error
	chown log:root /var/log/apache2/ssl_access
	chmod 2750 /var/log/apache2/ssl_access
	chown log:root /var/log/apache2/ssl_error
	chmod 2750 /var/log/apache2/ssl_error
	chown log:root /var/log/apache2/ssl_request
	chmod 2750 /var/log/apache2/ssl_request
	chmod 600 /var/log/apache2/access_log
	chmod 600 /var/log/apache2/error_log
	chmod 600 /var/log/apache2/ssl_access_log
	chmod 600 /var/log/apache2/ssl_error_log
	chmod 600 /var/log/apache2/ssl_request_log
	chown log:root /var/log/apache2/*/{lock,state,newstate,current} 2>/dev/null
}
