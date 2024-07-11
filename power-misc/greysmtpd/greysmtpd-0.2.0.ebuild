# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="tcpserver-compatible anti-spam (greylisting) smtpd"
HOMEPAGE="http://powerman.name/soft/greysmtpd.html"
SRC_URI="http://powerman.name/download/greysmtpd/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="virtual/qmail"
RDEPEND="${DEPEND}
	dev-perl/Net-DNS-Async-Simple"

src_install() {
	dobin greysmtpd
	einstalldocs

	dodir /var/greysmtpd/{0..255}
	fowners -R qmaild:root /var/greysmtpd

	exeinto /etc/cron.hourly
	doexe "$FILESDIR"/greysmtpd-cleanup.sh
}

pkg_postinst() {
	einfo 'To activate greysmtpd add into /var/qmail/control/conf-smtpd line:'
	einfo 'QMAIL_SMTP_PRE="${QMAIL_SMTP_PRE} greysmtpd"'
}
