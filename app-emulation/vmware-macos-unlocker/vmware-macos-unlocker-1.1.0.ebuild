# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="Workstation 8 and Fusion 4 Mac OS X Unlocker"
HOMEPAGE="http://www.insanelymac.com/forum/index.php?showtopic=268531"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/unlock-all-v110/src"

src_unpack() {
	unzip "${FILESDIR}"/unlock-all-v110.zip
}

src_prepare() {
	epatch "${FILESDIR}"/path.patch
}

src_install() {
	mv Unlocker.Linux vmware-macos-unlocker
	dobin vmware-macos-unlocker
}

