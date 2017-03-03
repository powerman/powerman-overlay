# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="CUDA-enabled FLAC encoder (former FlaCuda)"
HOMEPAGE="http://cue.tools/wiki/FLACCL"
SRC_URI="http://www.cuetools.net/install/CUETools_${PV}.zip"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/mono
	x11-drivers/nvidia-drivers"

S="${WORKDIR}/CUETools_${PV}"

src_install() {
	insinto "/usr/$(get_libdir)/${PN}/"
	doins CUETools.FLACCL.cmd.exe
	doins CUETools.Codecs.dll
	doins plugins/CUETools.Codecs.FLACCL.dll
	doins plugins/CUETools.Codecs.FLAKE.dll
	doins plugins/OpenCLNet.dll
	doins plugins/flac.cl

	make_wrapper "${PN}" "mono /usr/$(get_libdir)/${PN}/CUETools.FLACCL.cmd.exe"
}
