# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Support fonts with double-width icons in xterm/rxvt-unicode/zsh/..."
HOMEPAGE="https://github.com/powerman/wcwidth-icons"
SRC_URI="https://github.com/powerman/wcwidth-icons/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_install() {
	emake DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install
}
