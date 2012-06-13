# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit flag-o-matic eutils

DESCRIPTION="an efficient, principled regular expression library"
HOMEPAGE="http://code.google.com/p/re2/"
SRC_URI=""

LICENSE="BSD"
SLOT=0
KEYWORDS="~x86 ~amd64"
IUSE="32bit"

RDEPEND=""

DEPEND="${RDEPEND}
	dev-vcs/mercurial
	"

pkg_setup() {
    if use 32bit ; then
        ABI="x86"
    fi
}

src_unpack() {
	hg clone https://re2.googlecode.com/hg ${P}
	cd "${S}"
	hg update -r c79416ca4228 || die
}

src_compile() {
	if use 32bit ; then
		# don't know why, but ABI=x86 doesn't work since libre2-120529
		append-cppflags -m32
		emake LDFLAGS="$LDFLAGS -m32"
	else
		emake
	fi
}

src_install() {
	dodir /usr/include/re2
	insinto /usr/include/re2
	doins re2/{re2,stringpiece,variadic_function}.h
	dolib obj/libre2.a
}

