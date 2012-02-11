# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="CUDA-enabled FLAC encoder"
HOMEPAGE="http://www.cuetools.net/doku.php/flacuda"
SRC_URI="http://www.cuetools.net/install/FlaCuda09Linux.rar"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/mono
		x11-drivers/nvidia-drivers"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	dobin "${FILESDIR}/flacuda"
	dobin CUETools.FlaCuda.exe
	dolib *.dll
}

