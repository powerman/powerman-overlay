# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Search dictionary located in MySQL database"
HOMEPAGE="http://powerman.name/Software.html"
SRC_URI="http://powerman.name/download/asdfDict/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86"
IUSE="X"

DEPEND="X? ( kde-base/kdialog x11-misc/xsel )"
RDEPEND=""

src_install() {
	dobin {asdfDict,asdfDict-search,asdfDict-setup}
	insinto /etc
	doins asdfDict.conf

	# If user wants GUI interface
	if use X; then
		dobin asdfDictX
	fi
}
