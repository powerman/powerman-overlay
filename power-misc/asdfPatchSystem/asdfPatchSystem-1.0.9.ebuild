# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Generate, distribute and apply patches to project"
HOMEPAGE="http://powerman.name/Software_asdf.html"
SRC_URI="http://powerman.name/download/asdf/asdfPatchSystem/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dobin asdfApplyPatch asdfDiff asdfPatch asdfReleasePatch
	dodoc .patchfiles.example-{ACCEPT,ASK}
}

