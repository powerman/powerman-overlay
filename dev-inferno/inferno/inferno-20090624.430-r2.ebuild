# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic eutils

DESCRIPTION="OS Inferno New Edition (svn)"
HOMEPAGE="http://inferno-os.googlecode.com/"
SRC_URI="http://inferno-os-downloads.googlecode.com/files/${P}.tar.bz2
	http://inferno-os-downloads.googlecode.com/files/acme-sac-fonts-20090624.209.tar.bz2"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="~x86"
IUSE="hardened X doc source"

RDEPEND=""

DEPEND="${RDEPEND}
	hardened? ( sys-apps/paxctl )
	"

src_unpack() {
	unpack ${P}.tar.bz2
	cd "${S}"
	unpack "acme-sac-fonts-20090624.209.tar.bz2"
	find -type d -name .svn -exec rm -rf {} \; &>/dev/null

	epatch "${FILESDIR}/listen.patch"
	epatch "${FILESDIR}/issue-122-csendalt.patch"
	epatch "${FILESDIR}/issue-147-wait.patch"
	epatch "${FILESDIR}/acme-fonts.patch"
}

src_compile() {
	export INFERNO_ROOT=$(pwd)
	perl -i -pe 's/^ROOT=.*/ROOT=$ENV{INFERNO_ROOT}/m' mkconfig
	perl -i -pe 's/^SYSHOST=.*/SYSHOST=Linux/m' mkconfig || die
	perl -i -pe 's/^OBJTYPE=.*/OBJTYPE=386/m'   mkconfig || die

	export PATH=$INFERNO_ROOT/Linux/386/bin:$PATH
	sh makemk.sh			|| die
	mk nuke					|| die
	if use X; then
		mk install			|| die
	fi
	mk CONF=emu-g install	|| die
	
	if use hardened ; then
		paxctl -psmxe Linux/386/bin/emu*
	fi

	# needed to allow rebuilding already installed inferno (with "use source")
	export INFERNO_ROOT="/usr/inferno"
	perl -i -pe 's/^ROOT=.*/ROOT=$ENV{INFERNO_ROOT}/m' mkconfig
}

src_install() {
	if ! use X ; then
		cp "${S}"/Linux/386/bin/emu{-g,}
	fi

	if ! use doc ; then
		rm -rf "${S}"/doc
	fi

	if ! use source ; then
		rm -rf "${S}"/{FreeBSD,Hp,Inferno,Irix,MacOSX,NetBSD,Nt,OpenBSD,Plan9,Solaris}
		rm -rf "${S}"/{asm,emu,include,lib?*,limbo,mkfiles,os,tools,utils}
		rm -rf "${S}"/{makemk.sh,mkconfig,mkfile}
	fi

	cat "${FILESDIR}/profile.env" >> "${S}"/lib/sh/profile

	insinto /usr/inferno
	doins -r "${S}"/*
	# Fix permissions
	find Linux/386/bin/ -type f -print0 |
		xargs -0 -I '{}' fperms +x /usr/inferno/'{}'
	find dis/ -type f -not -name '*.dis' -print0 |
		xargs -0 -I '{}' fperms +x /usr/inferno/'{}'
	fperms 0600 /usr/inferno/keydb/keys

	# Setup the path environment
	doenvd "${FILESDIR}/20inferno"
}

pkg_postinst() {
	# Unpack man pages (packed by doins)
	find "${ROOT}"/usr/inferno/man/ -name '*.bz2' -exec bzip2 -f -d {} \;
}

pkg_prerm() {
	# Pack man pages back (origianlly packed by doins then unpacked in postinst)
	find "${ROOT}"/usr/inferno/man/ -type f -exec bzip2 -f {} \;
}

