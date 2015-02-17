# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
MODULE_AUTHOR=RWSTAUNER
MODULE_VERSION=2.000
inherit perl-module

DESCRIPTION='Convert POD to Markdown'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
perl_meta_configure() {
	# ExtUtils::MakeMaker 6.30 ( 6.300.0 )
	echo \>=virtual/perl-ExtUtils-MakeMaker-6.30
}
perl_meta_runtime() {
	# Pod::ParseLink 1.10 ( 1.100.0 )
	echo \>=virtual/perl-podlators-1.100.0
	# Pod::Parser
	echo virtual/perl-Pod-Parser
	# parent
	echo virtual/perl-parent
	# perl 5.008 ( 5.8.0 )
	echo \>=dev-lang/perl-5.8.0
	# strict
	echo dev-lang/perl
	# warnings
	echo dev-lang/perl
}
perl_meta_test() {
	# ExtUtils::MakeMaker
	echo virtual/perl-ExtUtils-MakeMaker
	# File::Find
	echo dev-lang/perl
	# File::Spec::Functions
	echo virtual/perl-File-Spec
	# File::Temp
	echo virtual/perl-File-Temp
	# List::Util
	echo virtual/perl-Scalar-List-Utils
	# Test::Differences
	echo dev-perl/Test-Differences
	# Test::More
	echo virtual/perl-Test-Simple
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
