# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
MODULE_AUTHOR=GENEHACK
MODULE_VERSION=0.035
inherit perl-module

DESCRIPTION='Wrap git(7) command-line interface'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
perl_meta_configure() {
	# ExtUtils::MakeMaker 6.30 ( 6.300.0 )
	echo \>=virtual/perl-ExtUtils-MakeMaker-6.30
}
perl_meta_runtime() {
	echo dev-perl/Devel-CheckBin
	# File::Temp
	echo virtual/perl-File-Temp
	# File::pushd
	echo dev-perl/File-pushd
	# IPC::Cmd
	echo virtual/perl-IPC-Cmd
	# IPC::Open3
	echo dev-lang/perl
	# Scalar::Util
	echo virtual/perl-Scalar-List-Utils
	# Sort::Versions
	echo dev-perl/Sort-Versions
	# Symbol
	echo dev-lang/perl
	# overload
	echo dev-lang/perl
	# perl 5.006 ( 5.6.0 )
	echo \>=dev-lang/perl-5.6.0
	# strict
	echo dev-lang/perl
	# warnings
	echo dev-lang/perl
}
perl_meta_test() {
	# Env::Path
	echo dev-perl/Env-Path
	# File::Path
	echo virtual/perl-File-Path
	# File::Spec
	echo virtual/perl-File-Spec
	# IO::File
	echo virtual/perl-IO
	# POSIX
	echo dev-lang/perl
	# Test::Deep
	echo dev-perl/Test-Deep
	# Test::Exception
	echo dev-perl/Test-Exception
	# Test::More
	echo virtual/perl-Test-Simple
	# Test::Most
	echo dev-perl/Test-Most
}
extra_deps() {
	echo dev-vcs/git
}
DEPEND="
	$(perl_meta_configure)
	$(perl_meta_runtime)
	test? ( $(perl_meta_test) )
	$(extra_deps)
"
RDEPEND="
	$(perl_meta_runtime)
	$(extra_deps)
"
SRC_TEST="do parallel"
