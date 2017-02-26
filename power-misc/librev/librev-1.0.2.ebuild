# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="Library for fake access to files from external app"
HOMEPAGE="http://powerman.name/soft/libREV.html"
SRC_URI="http://powerman.name/download/librev/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dolib libREV.so*
}
