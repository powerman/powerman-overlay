# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="add GnuPG info into email headers while delivering"
HOMEPAGE="http://powerman.name/soft/"
SRC_URI="http://powerman.name/download/${PN}/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="app-crypt/gnupg"
RDEPEND=""

src_install() {
	dobin addgpginfo
}
