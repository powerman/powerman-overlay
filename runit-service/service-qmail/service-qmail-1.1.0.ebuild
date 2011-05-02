# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Service for virtual/qmail"
HOMEPAGE="http://powerman.name/RTFM/runit.html"
SRC_URI="http://powerman.name/download/Gentoo/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=""
RDEPEND="
	runit-service/setupservices
	virtual/qmail
	sys-apps/ucspi-ssl
	"

src_install() {
	cp -a * "${D}"

	# add required files for qmail-pop3s service
	ctldir="/var/qmail/control"
	mkdir -p "${D}$ctldir"
	cp -a "$ctldir/conf-pop3d" "${D}$ctldir/conf-pop3sd"
	cat <<'EOF' >> "${D}$ctldir/conf-pop3sd"
export CADIR="/usr/share/ca-certificates"                                       
export CAFILE="/var/qmail/control/pop3cert.pem"                                 
export CERTFILE="/var/qmail/control/pop3cert.pem"                               
export KEYFILE="/var/qmail/control/pop3cert.pem"                                
EOF
	svdir="/var/qmail/supervise"
	mkdir -p "${D}$svdir"
	cp -a "$svdir/qmail-pop3d" "${D}$svdir/qmail-pop3sd"
	sed -i 's/tcpserver/sslserver/'        "${D}$svdir/qmail-pop3sd/run"
	sed -i 's/SERVICE=pop3/SERVICE=pop3s/' "${D}$svdir/qmail-pop3sd/run"
	sed -i 's/SERVICE=pop3/SERVICE=pop3s/' "${D}$svdir/qmail-pop3sd/log/run"
}

pkg_postinst() {
	tcpdir="/etc/tcprules.d"
	if ! grep tcp.qmail-pop3s.cdb "$tcpdir/Makefile.qmail" &>/dev/null; then
		ewarn "Adding tcp.qmail-pop3s.cdb support to $tcpdir/Makefile.qmail"
		sed -i 's/\(tcp.qmail-pop3.cdb\)/\1 tcp.qmail-pop3s.cdb/' \
			"$tcpdir/Makefile.qmail"
	fi
	if ! [ -f "$tcpdir/tcp.qmail-pop3s" ]; then
		ewarn "Duplicating $tcpdir/tcp.qmail-pop3 to $tcpdir/tcp.qmail-pop3s"
		cp -a "$tcpdir/tcp.qmail-pop3" "$tcpdir/tcp.qmail-pop3s"
	fi
	if ! [ -f "$tcpdir/tcp.qmail-pop3s.cdb" ]; then
		ewarn "Generating $tcpdir/tcp.qmail-pop3s.cdb"
		make tcp.qmail-pop3s.cdb -C "$tcpdir"
	fi

	if ! [ -f /var/qmail/control/pop3cert.pem ]; then
		ewarn "To use qmail-pop3sd you need to create server certificate"
		ewarn "and save it to /var/qmail/control/pop3cert.pem"
	fi

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
}

