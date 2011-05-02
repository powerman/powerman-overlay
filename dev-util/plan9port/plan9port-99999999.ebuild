# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/plan9port/plan9port-20080130.ebuild,v 1.1 2008/03/11 13:03:53 coldwind  Exp $

inherit eutils

DESCRIPTION="Plan 9 From User Space"
HOMEPAGE="http://swtch.com/plan9port/"
SRC_URI="http://swtch.com/plan9port/${PN}.tgz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-apps/xauth"
RDEPEND=""

S="${WORKDIR}/plan9"

PORTAGE_COMPRESS=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# TODO: install utils
	# troff

	# Fix lex error
	sed -i 's/9 lex/lex/' "src/cmd/mkfile"

	# Fix paths.
	find -type f -exec sed -i 's!/usr/local/plan9!/usr/lib/plan9!g' '{}' ';' 

	epatch "${FILESDIR}/9660srv_errno.patch"
}

src_compile() {
	einfo "															 "
	einfo "Compiling Plan 9 from User Space can take a very long time   "
	einfo "depending on the speed of your computer. Please be patient!  "
	einfo "															 "
	./INSTALL -b || die
}

src_install() {
	export PORTAGE_COMPRESS=""	# don't bzip man pages
	dodir /usr/lib/plan9
	mv "${S}" "${D}"/usr/lib/
	doenvd "${FILESDIR}/30plan9"
}

pkg_postinst() {
	einfo "															 "
	einfo "Recalibrating Plan 9 from User Space to its new environment. "
	einfo "This could take a while...								   "
	einfo "															 "

	cd /usr/lib/plan9
	export PATH="$PATH:/usr/lib/plan9"
	./INSTALL -c &> /dev/null

	elog "															 "
	elog "Plan 9 from User Space has been successfully installed into  "
	elog "/usr/lib/plan9. Your PLAN9 and PATH environment variables	"
	elog "have also been appropriately set, please use env-update and  "
	elog "source /etc/profile to bring that into immediate effect.	 "
	elog "															 "
	elog "Please note that \${PLAN9}/bin has been appended to the *end*"
	elog "or your PATH to prevent conflicts. To use the Plan9 versions "
	elog "of common UNIX tools, use the absolute path:				 "
	elog "/usr/lib/plan9/bin or the 9 command (eg: 9 troff)			"
	elog "															 "
	elog "Please report any bugs to bugs.gentoo.org, NOT Plan9Port.	"
	elog "															 "
}
