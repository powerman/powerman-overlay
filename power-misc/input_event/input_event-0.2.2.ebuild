# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="Enable the use and configuration of special keyboard keys"
HOMEPAGE="http://powerman.name/soft/input_event.html"
SRC_URI="http://powerman.name/download/input_event/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin XGetInputFocus
	dosbin input_event
	insinto /etc
	doins input_event.actions
}
