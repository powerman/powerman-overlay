# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Service for www-servers/nginx"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="runit-service/setupservices"
RDEPEND=">=sys-process/runit-2.1.2-r1
	www-servers/nginx"

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
	if [ -f "${ROOT}"var/log/nginx/access_log ]; then
		mv "${ROOT}"var/log/nginx/access_log "${ROOT}"var/log/nginx/access_log.old || die
		mv "${ROOT}"var/log/nginx/error_log  "${ROOT}"var/log/nginx/error_log.old || die
		ewarn "You current logs was renamed to ${ROOT}var/log/nginx/{access,error}_log.old."
		ewarn "You should start new services now and restart nginx:"
		ewarn "    ln -s /etc/sv/nginx-log-access ${ROOT%/}${SVDIR%/}/"
		ewarn "    ln -s /etc/sv/nginx-log-error  ${ROOT%/}${SVDIR%/}/"
		ewarn "    sv t nginx"
	fi
}
