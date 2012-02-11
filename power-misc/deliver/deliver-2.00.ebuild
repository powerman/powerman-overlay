# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Control email delivery (for .qmail only)"
HOMEPAGE="http://powerman.name/soft/deliver.html"
SRC_URI="http://powerman.name/download/deliver/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dobin deliver
}

