# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="GUI Client for GRPC Services"
HOMEPAGE="https://github.com/uw-labs/bloomrpc"
SRC_URI="https://github.com/uw-labs/bloomrpc/releases/download/$PV/bloomrpc_${PV}_amd64.deb"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

QA_PREBUILT="*"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	dodir opt/bloomrpc
	cp -a "${S}"/opt/BloomRPC/* "${D}/opt/bloomrpc/" || die
	dosym "${EPREFIX}/opt/bloomrpc/bloomrpc" "/usr/bin/bloomrpc"
}
