# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
MODULE_AUTHOR=FAYLAND
MODULE_VERSION=0.30
inherit perl-module

DESCRIPTION='Automatically convert POD to a README for Dist::Zilla'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
perl_meta_configure() {
	# ExtUtils::MakeMaker 6.30 ( 6.300.0 )
	echo \>=virtual/perl-ExtUtils-MakeMaker-6.30
}
perl_meta_runtime() {
	# Dist::Zilla::File::InMemory
	echo dev-perl/Dist-Zilla
	# Dist::Zilla::Role::InstallTool 5 ( 5.0.0 )
	echo \>=dev-perl/Dist-Zilla-5.0.0
	# Moose
	echo dev-perl/Moose
	# Moose::Autobox
	echo dev-perl/Moose-Autobox
	# Pod::Readme
	echo \>=dev-perl/Pod-Readme-1.001.1
	# Pod::Simple 3.23 ( 3.230.0 )
	echo \>=virtual/perl-Pod-Simple-3.230.0
	# Pod::Text
	echo virtual/perl-podlators
}
perl_meta_test() {
	# File::Spec
	echo virtual/perl-File-Spec
	# IO::Handle
	echo virtual/perl-IO
	# IPC::Open3
	# echo dev-lang/perl
	# Test::More
	echo virtual/perl-Test-Simple
	# strict
	# echo dev-lang/perl
	# warnings
	#echo dev-lang/perl
}
DEPEND="
	$(perl_meta_configure)
	$(perl_meta_runtime)
	test? ( $(perl_meta_test) )
"
RDEPEND="
	$(perl_meta_runtime)
"
SRC_TEST="do parallel"
