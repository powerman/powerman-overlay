# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="font for console, dos/koi/win mappings for screen and keyboard"
HOMEPAGE="http://powerman.name/"
SRC_URI="http://powerman.name/download/font/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	insinto /usr/share
	doins -r usr/share/{consolefonts,consoletrans,keymaps}
}
