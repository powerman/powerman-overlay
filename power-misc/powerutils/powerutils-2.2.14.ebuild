# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A bundle of useful small utilities"
HOMEPAGE="http://powerman.name/soft/powerutils.html"
SRC_URI="http://powerman.name/download/powerutils/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	dobin bin/*
	dosbin sbin/*
}
