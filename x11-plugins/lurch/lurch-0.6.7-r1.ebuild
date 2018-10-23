# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils

DESCRIPTION="Implements the OMEMO (XEP-0384) extension for libpurple."
HOMEPAGE="https://github.com/gkdr/lurch/"
SRC_URI="https://github.com/gkdr/lurch/archive/v${PV}.tar.gz -> ${P}.tar.gz
https://github.com/gkdr/libomemo/archive/v0.6.2.tar.gz -> ${P}-libomemo-0.6.2.tar.gz
https://github.com/gkdr/axc/archive/v0.3.1.tar.gz -> ${P}-axc-0.3.1.tar.gz
https://github.com/WhisperSystems/libsignal-protocol-c/archive/v2.3.1.tar.gz -> ${P}-libsignalc-2.3.1.tar.gz
"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""
RDEPEND="
	net-im/pidgin
	dev-libs/mxml
"

DEPEND="
	${RDEPEND}
	sys-devel/make
	app-arch/tar
"

#S=${WORKDIR}/lurch-15df7636a8f1a8033cc75db670e5191f09c2fe09

src_unpack() {
	unpack "${P}.tar.gz"
	cd "${S}/lib" || die
	tar xf "${DISTDIR}/${P}-libomemo-0.6.2.tar.gz" -C libomemo --strip-components 1 || die "Failed to unpack ${P}-libomemo-0.6.2.tar.gz"
	tar xf "${DISTDIR}/${P}-axc-0.3.1.tar.gz" -C axc --strip-components 1 || die "Failed to unpack ${P}-axc-0.3.1.tar.gz"
	cd ./axc/lib
	tar xf "${DISTDIR}/${P}-libsignalc-2.3.1.tar.gz" -C libsignal-protocol-c --strip-components 1 || die "Failed to unpack ${P}-libsignalc-2.3.1.tar.gz"
}
