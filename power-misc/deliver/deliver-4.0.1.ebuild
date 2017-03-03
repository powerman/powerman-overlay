# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Control email delivery (for .qmail only)"
HOMEPAGE="http://powerman.name/soft/deliver.html"
SRC_URI="http://powerman.name/download/deliver/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="mail-filter/normalizemime app-i18n/enca"

src_install() {
	dobin deliver
}
