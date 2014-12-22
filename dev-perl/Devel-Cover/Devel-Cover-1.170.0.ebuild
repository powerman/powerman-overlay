# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
MODULE_AUTHOR=PJCJ
MODULE_VERSION=1.17
inherit perl-module

DESCRIPTION='Code coverage metrics for Perl'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
perl_meta_configure() {
	# ExtUtils::MakeMaker
	echo virtual/perl-ExtUtils-MakeMaker
}
perl_meta_runtime() {
	# Digest::MD5
	echo virtual/perl-Digest-MD5
	# Storable
	echo virtual/perl-Storable
	# perl 5.006001 ( 5.6.1 )
	echo \>=dev-lang/perl-5.6.1
}
perl_meta_test() {
	# Test::More
	echo virtual/perl-Test-Simple
	# Test::Warn
	echo dev-perl/Test-Warn
}
DEPEND="
	$(perl_meta_configure)
	$(perl_meta_runtime)
	test? ( $(perl_meta_test) )
"
RDEPEND="
	$(perl_meta_runtime)
"
SRC_TEST="do"
