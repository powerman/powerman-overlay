# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
MODULE_AUTHOR=BINGOS
MODULE_VERSION=0.46
inherit perl-module

DESCRIPTION='Automatically include GitHub meta information in META.yml'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
perl_meta_configure() {
	# ExtUtils::MakeMaker 6.30 ( 6.300.0 )
	echo \>=virtual/perl-ExtUtils-MakeMaker-6.30
}
perl_meta_runtime() {
	# Dist::Zilla 4.101582 ( 4.101.582 )
	echo \>=dev-perl/Dist-Zilla-4.101.582
	# Dist::Zilla::Role::MetaProvider 4.101582 ( 4.101.582 )
	echo \>=dev-perl/Dist-Zilla-4.101.582
	# IPC::Cmd
	echo virtual/perl-IPC-Cmd
	# Moose 1.07 ( 1.70.0 )
	echo \>=dev-perl/Moose-1.70.0
	# MooseX::Types::URI 0.03 ( 0.30.0 )
	echo \>=dev-perl/MooseX-Types-URI-0.30.0
	# perl 5.008005 ( 5.8.5 )
	echo \>=dev-lang/perl-5.8.5
	# version
	echo virtual/perl-version
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
