# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
MODULE_AUTHOR=ETHER
MODULE_VERSION=1.003003
inherit perl-module

DESCRIPTION='use Cpanel::JSON::XS with a fallback to JSON::XS and JSON::PP'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
perl_meta_configure() {
	# ExtUtils::MakeMaker
	echo virtual/perl-ExtUtils-MakeMaker
}
perl_meta_build() {
	# Test::More 0.88 ( 0.880.0 )
	echo virtual/perl-Test-Simple
	# Test::Without::Module 0.27 ( 0.270.0 )
	echo \>=dev-perl/Test-Without-Module-0.170.0
}
perl_meta_runtime() {
	# JSON::PP 2.2702 ( 2.272.20 )
	echo \>=virtual/perl-JSON-PP-2.272.20
	# perl 5.006 ( 5.6.0 )
	echo \>=dev-lang/perl-5.6.0
}
DEPEND="
	$(perl_meta_configure)
	$(perl_meta_build)
	$(perl_meta_runtime)
"
RDEPEND="
	$(perl_meta_runtime)
"
#SRC_TEST="do parallel"
