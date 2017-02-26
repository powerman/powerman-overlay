# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="Ease to use wrapper tools for ssh and scp"
HOMEPAGE="http://powerman.name/soft/remote.html"
SRC_URI="http://powerman.name/download/remote/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dobin {download,remote,upload}
	dodoc .remote
}
