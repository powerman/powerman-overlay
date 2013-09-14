# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="CUDA-enabled FLAC encoder (former FlaCuda)"
HOMEPAGE="http://www.cuetools.net/wiki/FLACCL"
SRC_URI="http://www.cuetools.net/install/flaccl03.rar"

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
	dobin CUETools.FLACCL.cmd.exe
	dolib *.dll
	dolib flac.cl
	dosym libOpenCL.so /usr/lib/libopencl.so
}

