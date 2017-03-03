# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font

DESCRIPTION="Another clean fixed font for the console and X11"
HOMEPAGE="http://powerman.name/config/font.html"
SRC_URI="http://powerman.name/download/font/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+psf raw +pcf inferno"
# Note: that pcf fonts can be loaded by freetype even if X is not installed.
# That's why configuration +pcf and -X is supported, bug #155783.
REQUIRED_USE="X? ( pcf )"

DEPEND="dev-lang/perl
	sys-apps/gawk
	app-arch/gzip
	pcf? ( x11-apps/bdftopcf )"
RDEPEND="psf? ( media-fonts/terminus-font[psf] )
	inferno? ( dev-inferno/inferno )"

FONTDIR=/usr/share/fonts/developer

src_configure() {
	# custom configure-like script
	econf \
		--psfdir=/usr/share/consolefonts \
		--acmdir=/usr/share/consoletrans \
		--unidir=/usr/share/consoletrans \
		--x11dir="${FONTDIR}"
}

src_compile() {
	use psf && emake psf txt
	use raw && emake raw
	use pcf && emake pcf
}

src_install() {
	use psf && emake DESTDIR="$D" install-psf install-uni install-acm install-ref
	use raw && emake DESTDIR="$D" install.raw
	use pcf && emake DESTDIR="$D" install-pcf
	if use inferno; then
		insinto /usr/inferno/fonts/developer
		doins subf/dev-*
	fi

	insinto "$FONTDIR"
	doins DeveloperBold.ttf
	doins DeveloperRawBold.ttf

	font_src_install
}
