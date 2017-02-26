# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils font

DESCRIPTION="Another clean fixed font for the console and X11"
HOMEPAGE="http://powerman.name/config/font.html"
SRC_URI="http://powerman.name/download/font/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+psf raw +pcf inferno"

DEPEND="dev-lang/perl
		sys-apps/gawk
		app-arch/gzip
		pcf? ( x11-apps/bdftopcf )
		inferno? ( dev-inferno/inferno )"
RDEPEND="psf? ( >=media-fonts/terminus-font-4.39-r1[psf] )"

FONTDIR=/usr/share/fonts/developer
DOCS="README"

pkg_setup() {
	# Note: that pcf fonts can be loaded by freetype even if X is not installed.
	# That's why configuration +pcf and -X is supported, bug #155783.
	if use X && ! use pcf ; then
		eerror "Fonts which works with Xserver are intalled only if pcf is enabled."
		die "Either disable X use flag or enabled pcf."
	fi

	font_pkg_setup
}

src_configure() {
	# custom configure-like script
	econf \
		--psfdir=/usr/share/consolefonts \
		--acmdir=/usr/share/consoletrans \
		--unidir=/usr/share/consoletrans \
		--x11dir=${FONTDIR}
}

src_compile() {
	if use psf; then emake psf txt || die; fi
	if use raw; then emake raw || die; fi
	if use pcf; then emake pcf || die; fi
}

src_install() {
	if use psf; then
		emake DESTDIR="${D}" install-psf install-uni install-ref || die
	fi
	if use raw; then
		emake DESTDIR="${D}" install.raw || die
	fi
	if use pcf; then
		emake DESTDIR="${D}" install-pcf || die
	fi
	if use inferno; then
		insinto /usr/inferno/fonts/developer
		doins subf/dev-*
	fi

	insinto "${FONTDIR}"
	doins DeveloperBold.ttf
	doins DeveloperRawBold.ttf

	font_src_install
}
