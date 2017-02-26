# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="tcpserver-compatible anti-spam (greylisting) smtpd"
HOMEPAGE="http://powerman.name/soft/greysmtpd.html"
SRC_URI="http://powerman.name/download/greysmtpd/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/qmail net-libs/adns"
RDEPEND=""

src_install() {
	dobin greysmtpd
	dodoc README
	dodir /var/greysmtpd
	for i in $(seq 0 255); do dodir /var/greysmtpd/$i; done

	exeinto /etc/cron.hourly
	doexe "${FILESDIR}"/greysmtpd-cleanup.sh
}

pkg_postinst() {
	chown -R qmaild:root /var/greysmtpd

	einfo 'To activate greysmtpd add into /var/qmail/control/conf-smtpd line:'
	einfo 'QMAIL_SMTP_PRE="${QMAIL_SMTP_PRE} greysmtpd"'
}
