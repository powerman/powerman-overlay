# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker xdg

DESCRIPTION="Cryptocurrency Wallet"
HOMEPAGE="https://www.exodus.com/"

SRC_URI="https://github.com/rustdesk/${PN}/releases/download/${PV}/${P}.deb"

LICENSE="AGPL-3.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

QA_PREBUILT="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	cp -a "${S}"/* "${D}" || die
# 	fperms 4755 "/usr/lib/exodus/chrome-sandbox"
}
