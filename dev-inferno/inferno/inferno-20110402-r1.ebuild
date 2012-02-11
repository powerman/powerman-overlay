# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic eutils

DESCRIPTION="OS Inferno Fourth Edition"
HOMEPAGE="http://inferno-os.googlecode.com/"
SRC_URI="http://www.vitanuova.com/dist/4e/inferno-20100120.tgz
	http://inferno-os-downloads.googlecode.com/files/acme-sac-fonts-20090624.209.tar.bz2
	http://inferno-re2.googlecode.com/files/inferno-re2-1.1.2.tgz
	"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="~x86 ~amd64"
IUSE="hardened X doc source re2 ipv6"

RDEPEND=""

DEPEND="${RDEPEND}
	hardened? ( sys-apps/paxctl )
	dev-vcs/mercurial
	!dev-inferno/inferno-font-bh
	re2? ( >=dev-libs/libre2-110302 )
	"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack inferno-20100120.tgz
	cd "${S}"
	hg pull	-r 98d226096414	|| die
	hg update				|| die
	unpack "acme-sac-fonts-20090624.209.tar.bz2"

	if ! use ipv6; then
		perl -i -pe 's/ipif6/ipif/g' emu/Linux/emu emu/Linux/emu-g
	fi

	if use re2; then
		unpack "inferno-re2-1.1.2.tgz"
		epatch "re2wrap.patch"
	fi

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
	export PORTAGE_COMPRESS=""	# don't bzip man pages

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
	if use source ; then
		doins -r "${S}"/.hg*
	fi
	# Fix permissions
	find Linux/386/bin/ -type f -print0 |
		xargs -0 -I '{}' fperms +x /usr/inferno/'{}'
	find dis/ -type f -not -name '*.dis' -print0 |
		xargs -0 -I '{}' fperms +x /usr/inferno/'{}'
	fperms 0600 /usr/inferno/keydb/keys

	# Setup the path environment
	doenvd "${FILESDIR}/20inferno"
}

