# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

DESCRIPTION="Simple and flexible incremental backup"
HOMEPAGE="http://powerman.name/soft/powerbackup.html"
SRC_URI="http://powerman.name/download/powerbackup/${P}.tgz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dobin bin/powerbackup
	exeinto /etc/powerbackup/
	doexe etc/powerbackup/{archive.*,tar.*}
	insinto /etc/powerbackup/
	doins etc/powerbackup/log.filter
	insopts -m0400
	doins etc/powerbackup/*.{pass,user}
}
