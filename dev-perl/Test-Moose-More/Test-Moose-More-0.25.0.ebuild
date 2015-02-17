# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
MODULE_AUTHOR=RSRCHBOY
MODULE_VERSION=0.025
inherit perl-module

DESCRIPTION='More tools for testing Moose packages'
LICENSE=" LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
perl_meta_configure() {
	# ExtUtils::MakeMaker 6.30 ( 6.300.0 )
	echo \>=virtual/perl-ExtUtils-MakeMaker-6.30
}
perl_meta_runtime() {
	# Data::OptList
	echo dev-perl/Data-OptList
	# Moose::Autobox
	echo dev-perl/Moose-Autobox
	# Moose::Util
	echo dev-perl/Moose
	# Moose::Util::TypeConstraints
	echo dev-perl/Moose
	# Perl6::Junction
	echo dev-perl/Perl6-Junction
	# Scalar::Util
	echo virtual/perl-Scalar-List-Utils
	# Sub::Exporter
	echo dev-perl/Sub-Exporter
	# Test::Builder
	echo virtual/perl-Test-Simple
	# Test::Moose
	echo dev-perl/Moose
	# Test::More
	echo virtual/perl-Test-Simple
	# perl 5.006 ( 5.6.0 )
	echo \>=dev-lang/perl-5.6.0
	# strict
	echo dev-lang/perl
	# warnings
	echo dev-lang/perl
}
perl_meta_test() {
	# File::Find
	echo dev-lang/perl
	# File::Temp
	echo virtual/perl-File-Temp
	# Moose
	echo dev-perl/Moose
	# Moose::Role
	echo dev-perl/Moose
	# TAP::SimpleOutput
	echo \>=dev-perl/TAP-SimpleOutput-0.2.0
	# Test::Builder::Tester
	echo virtual/perl-Test-Simple
	# Test::CheckDeps 0.010
	echo \>=dev-perl/Test-CheckDeps-0.10.0
	# Test::More 0.94 ( 0.940.0 )
	echo \>=virtual/perl-Test-Simple-0.94
	# namespace::autoclean
	echo dev-perl/namespace-autoclean
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
