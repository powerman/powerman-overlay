# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Keyrus-based fonts for X and console, dos/koi/win mappings"
HOMEPAGE="http://powerman.name/"
SRC_URI="http://powerman.name/download/font/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="X"

DEPEND="X? ( x11-apps/mkfontdir )"
RDEPEND=""

src_install() {
	insinto /usr/share
	doins -r usr/share/{consolefonts,consoletrans,keymaps}

	# If user wants fonts for X11
	if use X; then
		insinto /usr/share/fonts/russify
		doins usr/share/fonts/russify/*
		mkfontdir ${D}/usr/share/fonts/russify
	fi
}

