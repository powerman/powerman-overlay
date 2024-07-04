# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Service for www-servers/apache-2"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="runit-service/setupservices"
RDEPEND=">=sys-process/runit-2.1.2-r1
	>=www-servers/apache-2"

src_install() {
	cp -a * "${D}"
	for d in var/log/*/{,*/}; do
		fowners log:root /"$d"
		fperms 0750 /"$d"
	done
	for f in var/log/*/*_log; do
		fperms 0600 /"$f"
	done
}

pkg_preinst() {
	if [ -f "${ROOT}"var/log/apache2/ssl_access_log ]; then
		mv "${ROOT}"var/log/apache2/ssl_access_log  "${ROOT}"var/log/apache2/ssl_access_log.old || die
		mv "${ROOT}"var/log/apache2/ssl_error_log   "${ROOT}"var/log/apache2/ssl_error_log.old || die
		mv "${ROOT}"var/log/apache2/ssl_request_log "${ROOT}"var/log/apache2/ssl_request_log.old || die
		ewarn "This package now contain 3 new services for ssl-logs."
		ewarn "You current logs was renamed to ${ROOT}var/log/apache2/ssl_*_log.old."
		ewarn "You should start new services now and restart apache:"
		ewarn "    ln -s /etc/sv/apache2-log-ssl-access  ${ROOT%/}${SVDIR%/}/"
		ewarn "    ln -s /etc/sv/apache2-log-ssl-error   ${ROOT%/}${SVDIR%/}/"
		ewarn "    ln -s /etc/sv/apache2-log-ssl-request ${ROOT%/}${SVDIR%/}/"
		ewarn "    sv t apache2"
	fi
}
