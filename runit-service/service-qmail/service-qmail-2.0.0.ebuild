# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Service for virtual/qmail"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="runit-service/setupservices"
RDEPEND=">=sys-process/runit-2.1.2-r1
	sys-apps/ucspi-ssl
	virtual/qmail"

src_install() {
	cp -a * "${D}"
	for d in var/log/*/{,*/{,*/}}; do
		fowners qmaill:root /"$d"
		fperms 0750 /"$d"
	done
}

pkg_postinst() {
	if [ -f "${ROOT}${QMAIL_CONTROLDIR}"/pop3cert.pem ]; then
		ewarn "Since netqmail-1.06 and service-qmail-1.2.0 service qmail-pop3sd provided"
		ewarn "by netqmail instead of service-qmail package."
		ewarn "Because of this change name of file with service certificate was changed."
		ewarn "Please rename your certificate:"
		ewarn "  mv ${ROOT}${QMAIL_CONTROLDIR}/{pop3cert,servercert}.pem"
	fi
}
