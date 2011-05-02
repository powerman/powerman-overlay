# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/runit/runit-1.5.0.ebuild,v 1.1 2006/04/20 03:18:13 vapier Exp $

inherit toolchain-funcs flag-o-matic

DESCRIPTION="A UNIX init scheme with service supervision"
HOMEPAGE="http://smarden.org/runit/"
SRC_URI="http://smarden.org/runit/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="static"

DEPEND=""

S=${WORKDIR}/admin/${P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# we either build everything or nothing static
	sed -i -e 's:-static: :' src/Makefile
	use static && append-ldflags -static

	echo "$(tc-getCC) ${CFLAGS}"  > src/conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > src/conf-ld
}

src_compile() {
	cd src
	emake || die "make failed"
}

src_install() {
	dodir /var
	keepdir /etc/runit{,/runsvdir{,/default}}
	dosym default /etc/runit/runsvdir/current
	dosym ../etc/runit/runsvdir/current /var/service

	cd src
	dobin $(<../package/commands) || die "dobin"
	dodir /sbin
	mv "${D}"/usr/bin/{runit-init,runit,utmpset} "${D}"/sbin/ || die "dosbin"

	cd "${S}"
	dodoc package/{CHANGES,README,THANKS,TODO}
	dohtml doc/*.html
	doman man/*.[18]

	exeinto /usr/share/runit/example
	doexe "${FILESDIR}"/{1,2,3,ctrlaltdel} || die

	exeinto /etc/cron.hourly
	doexe "${FILESDIR}"/runit-zombie-fix.sh
}

