# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="Cryptocurrency Wallet"
HOMEPAGE="https://www.exodus.com/"

SRC_URI="https://github.com/rustdesk/${PN}/releases/download/nightly/rustdesk-1.2.0-x86_64-unknown-linux-gnu-ubuntu-18.04.deb"

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
	dosym -r /usr/lib/rustdesk/rustdesk /usr/bin/rustdesk
}
