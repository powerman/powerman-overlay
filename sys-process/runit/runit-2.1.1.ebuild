# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/runit/runit-2.1.1.ebuild,v 1.2 2011/06/15 18:55:12 flameeyes Exp $

EAPI="3"

inherit toolchain-funcs flag-o-matic

DESCRIPTION="A UNIX init scheme with service supervision"
HOMEPAGE="http://smarden.org/runit/"
SRC_URI="http://smarden.org/runit/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="static"

S=${WORKDIR}/admin/${P}/src

src_prepare() {
	# we either build everything or nothing static
	sed -i -e 's:-static: :' src/Makefile
}

src_configure() {
	use static && append-ldflags -static

	echo "$(tc-getCC) ${CFLAGS}"  > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
}

src_install() {
	dodir /var
	keepdir /etc/runit{,/runsvdir{,/default}}
	dosym default /etc/runit/runsvdir/current
	dosym ../etc/runit/runsvdir/current /var/service

	dobin $(<../package/commands) || die "dobin"
	dodir /sbin
	mv "${D}"/usr/bin/{runit-init,runit,utmpset} "${D}"/sbin/ || die "dosbin"

	cd "${S}"/..
	dodoc package/{CHANGES,README,THANKS,TODO}
	dohtml doc/*.html
	doman man/*.[18]

	exeinto /usr/share/runit/example
	doexe "${FILESDIR}"/{1,2,3,ctrlaltdel} || die
}
