# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit flag-o-matic eutils pax-utils

DESCRIPTION="OS Inferno Fourth Edition"
HOMEPAGE="https://bitbucket.org/inferno-os/inferno-os"
SRC_URI="http://www.vitanuova.com/dist/4e/inferno-20150328.tgz"

LICENSE="GPL-2"
SLOT=0
KEYWORDS="~x86 ~amd64"
IUSE="X doc source re2 cjson ipv6"

RDEPEND=""

DEPEND="${RDEPEND}
	dev-vcs/mercurial
	dev-vcs/git
	re2? ( >=dev-libs/re2-0_p20130712[abi_x86_32] )
	amd64? (
		X? ( || (
			(
				x11-libs/libX11[abi_x86_32(-)]
				x11-libs/libXext[abi_x86_32(-)]
			)
			app-emulation/emul-linux-x86-xlibs
		) )
    )
	"

S="${WORKDIR}/${PN}"

INFERNO_REV=7110524
RE2_REV=1.2.5
CJSON_REV=0.3.3

src_unpack() {
	unpack inferno-20150328.tgz
	cd "${S}"
	hg revert --no-backup $(hg status | grep ^M | sed 's/^M //')
	hg pull	-r $INFERNO_REV	|| die
	hg update				|| die
	rm -rf .hg

	if ! use ipv6; then
		perl -i -pe 's/ipif6/ipif/g' emu/Linux/emu emu/Linux/emu-g
	fi

	if use re2; then
		git clone https://github.com/powerman/inferno-re2.git tmp/inferno-re2
		cd tmp/inferno-re2; git checkout $RE2_REV; cd ../..
		cp -a tmp/inferno-re2/* ./
		rm -rf tmp/inferno-re2
		./patch.re2
	fi

	if use cjson; then
		git clone https://github.com/powerman/inferno-cjson.git tmp/inferno-cjson
		cd tmp/inferno-cjson; git checkout $CJSON_REV; cd ../..
		cp -a tmp/inferno-cjson/* ./
		rm -rf tmp/inferno-cjson
		./patch.cjson
	fi

	epatch "${FILESDIR}/issue-122-csendalt.patch"
	epatch "${FILESDIR}/issue-147-wait.patch"
	epatch "${FILESDIR}/issue-271-microsec.patch"
	epatch "${FILESDIR}/issue-274-execatidle.patch"
	epatch "${FILESDIR}/issue-287-man-index.patch"
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

	pax-mark pems Linux/386/bin/emu*

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
		rm -rf "${S}"/{DragonFly,FreeBSD,Hp,Inferno,Irix,MacOSX,NetBSD,Nt,OpenBSD,Plan9,Solaris}
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

    # We don't compress to keep support for Inferno's man
    docompress -x /usr/inferno/man
}

