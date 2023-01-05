# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="Cryptocurrency Wallet"
HOMEPAGE="https://atomicwallet.io"

MY_PV="$(ver_cut 1-3)-$(ver_cut 4 ${PV/p//})"
SRC_URI="https://get.atomicwallet.io/download/atomicwallet-${MY_PV}.deb"

LICENSE="all-rights-reserved no-source-code"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

QA_PREBUILT="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	bzip2 -d "${S}/usr/share/doc/atomic/changelog.bz2"
	mv "${S}/usr/share/doc/atomic" "${S}/usr/share/doc/${P}"
	cp -a "${S}"/* "${D}" || die
	dosym "${EPREFIX}/opt/Atomic Wallet/atomic" "/usr/bin/atomic"
	fperms 4755 "/opt/Atomic Wallet/chrome-sandbox"
}
