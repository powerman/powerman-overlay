# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
MODULE_AUTHOR=DAGOLDEN
MODULE_VERSION=0.007
inherit perl-module

DESCRIPTION='Ensure Changes has content before releasing'
LICENSE=" Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
perl_meta_configure() {
	# ExtUtils::MakeMaker 6.30 ( 6.300.0 )
	echo \>=virtual/perl-ExtUtils-MakeMaker-6.300.0
}
perl_meta_runtime() {
	# Dist::Zilla 2.100950 ( 2.100.950 )
	echo \>=dev-perl/Dist-Zilla-2.100.950
	# Dist::Zilla::Plugin::InlineFiles
	echo dev-perl/Dist-Zilla
	# Dist::Zilla::Role::BeforeRelease
	echo dev-perl/Dist-Zilla
	# Dist::Zilla::Role::TextTemplate
	echo dev-perl/Dist-Zilla
	# File::pushd
	echo dev-perl/File-pushd
	# Moose 0.99 ( 0.990.0 )
	echo \>=dev-perl/Moose-0.990.0
	# autodie 2.00 ( 2.0.0 )
	echo \>=virtual/perl-autodie-2.0.0
	# namespace::autoclean 0.09 ( 0.90.0 )
	echo \>=dev-perl/namespace-autoclean-0.90.0
	# perl 5.006 ( 5.6.0 )
	echo \>=dev-lang/perl-5.6.0
	# strict
	echo dev-lang/perl
	# warnings
	echo dev-lang/perl
}
perl_meta_test() {
	# Capture::Tiny
	echo dev-perl/Capture-Tiny
	# Cwd
	echo virtual/perl-File-Spec
	# Dist::Zilla::Tester
	echo dev-perl/Dist-Zilla
	# File::Find
	echo dev-lang/perl
	# File::Temp
	echo virtual/perl-File-Temp
	# Path::Class
	echo dev-perl/Path-Class
	# Test::Harness
	echo virtual/perl-Test-Harness
	# Test::More 0.88 ( 0.880.0 )
	echo \>=virtual/perl-Test-Simple-0.88
	# Try::Tiny
	echo dev-perl/Try-Tiny
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
