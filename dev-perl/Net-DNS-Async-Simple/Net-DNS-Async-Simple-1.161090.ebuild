# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=DIEDERICH
DIST_VERSION=1.161090
inherit perl-module

DESCRIPTION="A simple wrapper around the excellent Net::DNS::Async"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="
	dev-perl/Modern-Perl
	dev-perl/Net-DNS
	dev-perl/Net-DNS-Async
	virtual/perl-Data-Dumper
	virtual/perl-Storable
	"
DEPEND="${RDEPEND}"
