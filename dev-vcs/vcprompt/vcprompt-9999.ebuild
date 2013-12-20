# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit mercurial

DESCRIPTION="show info about the current working directory for various VCS for PS1"
HOMEPAGE="https://bitbucket.org/powerman/vcprompt"
EHG_REPO_URI="https://bitbucket.org/powerman/vcprompt"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=""

src_install() {
	dobin "${PN}"
	dobin "${PN}"-hgst
	doman "${PN}".1
	dodoc README.txt
}
