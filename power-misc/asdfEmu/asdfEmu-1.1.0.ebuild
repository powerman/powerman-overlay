# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Start OS Inferno and bind .lib/inferno/ to home directory"
HOMEPAGE="http://powerman.name/Software_asdf.html"
SRC_URI="http://powerman.name/download/asdf/asdfEmu/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=dev-inferno/inferno-20090624.430"
RDEPEND=""

src_install() {
	dobin asdfEmu
}

