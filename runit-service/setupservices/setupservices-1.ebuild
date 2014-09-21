# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit user

DESCRIPTION="Setup system to use runit services"
HOMEPAGE="http://powerman.name/"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	newenvd "${FILESDIR}"/services.envd 10services
}

pkg_setup() {
	enewuser log -1 -1 -1 nofiles
}

