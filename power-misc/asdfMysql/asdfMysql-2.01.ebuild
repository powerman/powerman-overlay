# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Start mysql client using db/user/pass from .lib/.db"
HOMEPAGE="http://powerman.name/Software_asdf.html"
SRC_URI="http://powerman.name/download/asdf/asdfMysql/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dobin asdfMysql
}

