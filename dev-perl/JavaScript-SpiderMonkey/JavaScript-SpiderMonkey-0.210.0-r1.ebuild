# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JavaScript-SpiderMonkey/JavaScript-SpiderMonkey-0.200.0.ebuild,v 1.1 2011/08/30 11:35:23 tove Exp $

EAPI=4

MODULE_AUTHOR=TBUSCH
MODULE_VERSION=0.21
inherit perl-module eutils

DESCRIPTION="Perl interface to the JavaScript Engine"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-perl/Log-Log4perl
	>=dev-lang/spidermonkey-1.8"
DEPEND="${RDEPEND}"

SRC_TEST=do

src_unpack(){
	perl-module_src_unpack
	epatch "${FILESDIR}/spidermonkey-1.8.patch"
	epatch "${FILESDIR}/spidermonkey-1.8.5.patch"
}
