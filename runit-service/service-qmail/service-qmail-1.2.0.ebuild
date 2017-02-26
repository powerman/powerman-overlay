# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="Service for virtual/qmail"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	virtual/qmail
	sys-apps/ucspi-ssl
	"

src_install() {
	cp -a * "${D}"
}

pkg_postinst() {
	chown qmaill:root /var/log/qmail
	chmod 2750 /var/log/qmail
	chown qmaill:root /var/log/qmail/qmail-pop3d
	chmod 2750 /var/log/qmail/qmail-pop3d
	chown qmaill:root /var/log/qmail/qmail-pop3d/all
	chmod 2755 /var/log/qmail/qmail-pop3d/all
	chown qmaill:root /var/log/qmail/qmail-smtpd
	chmod 2750 /var/log/qmail/qmail-smtpd
	chown qmaill:root /var/log/qmail/qmail-smtpd/all
	chmod 2755 /var/log/qmail/qmail-smtpd/all
	chown qmaill:root /var/log/qmail/qmail-send
	chmod 2750 /var/log/qmail/qmail-send
	chown qmaill:root /var/log/qmail/qmail-send/all
	chmod 2755 /var/log/qmail/qmail-send/all
	chown qmaill:root /var/log/qmail/qmail-pop3sd
	chmod 2750 /var/log/qmail/qmail-pop3sd
	chown qmaill:root /var/log/qmail/qmail-pop3sd/all
	chmod 2755 /var/log/qmail/qmail-pop3sd/all
	chown qmaill:root /var/log/qmail/*/*/{lock,state,newstate,current} 2>/dev/null

	if [ -f /var/qmail/control/pop3cert.pem ]; then
		ewarn "Since netqmail-1.06 and service-qmail-1.2.0 service qmail-pop3sd provided"
		ewarn "by netqmail instead of service-qmail package."
		ewarn "Because of this change name of file with service certificate was changed."
		ewarn "Please rename your certificate:"
		ewarn "  # mv /var/qmail/control/pop3cert.pem /var/qmail/control/servercert.pem"
	fi
}
