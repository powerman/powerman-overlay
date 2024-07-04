# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Setup system to use runit services"
HOMEPAGE="http://powerman.name/"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="acct-user/log"

src_unpack() {
	mkdir -p "${S}"
}

src_install() {
	newenvd "${FILESDIR}"/services.envd 10services
}
