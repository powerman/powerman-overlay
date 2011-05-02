# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ 

inherit eutils versionator

MY_P="${PN}-$(get_version_component_range 1-2)"
MY_P="${MY_P}-u$(get_version_component_range 3)"
MY_P="${MY_P}-b$(get_version_component_range 4)"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Unix port of Monkey's Audio codec"
HOMEPAGE="http://sourceforge.net/projects/mac-port"
SRC_URI="http://dl.liveforge.org/${PN}/${MY_P}.tar.gz"

# License status is unclear, see discussion in https://bugs.gentoo.org/show_bug.cgi?id=94477
LICENSE="unknown"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="backward-compatible"

DEPEND="virtual/libc
	x86? ( dev-lang/nasm )"

src_compile() {
	econf `use_enable backward-compatible backward` || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS INSTALL NEWS README TODO COPYING 
	dohtml ${S}/src/License.htm	${S}/src/Readme.htm
}
