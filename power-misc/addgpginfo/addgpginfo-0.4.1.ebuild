# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="add GnuPG info into email headers while delivering"
HOMEPAGE="http://powerman.name/soft/"
SRC_URI="http://powerman.name/download/${PN}/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=app-crypt/gnupg-2.1"

src_install() {
	dobin addgpginfo
}
