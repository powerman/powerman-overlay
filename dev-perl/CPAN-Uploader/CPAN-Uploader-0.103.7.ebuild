# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
MODULE_AUTHOR=RJBS
MODULE_VERSION=0.103007
inherit perl-module

DESCRIPTION='upload things to the CPAN'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
perl_meta_configure() {
	# ExtUtils::MakeMaker 6.30 ( 6.300.0 )
	echo \>=virtual/perl-ExtUtils-MakeMaker-6.30
}
perl_meta_runtime() {
	echo dev-perl/Config-Identity
	# Carp
	echo dev-lang/perl
	# Data::Dumper
	echo virtual/perl-Data-Dumper
	# File::Basename
	echo dev-lang/perl
	# File::HomeDir
	echo dev-perl/File-HomeDir
	# File::Spec
	echo virtual/perl-File-Spec
	# Getopt::Long::Descriptive 0.084 ( 0.84.0 )
	echo \>=dev-perl/Getopt-Long-Descriptive-0.84.0
	# HTTP::Request::Common
	echo dev-perl/HTTP-Message
	# HTTP::Status
	echo dev-perl/HTTP-Message
	# LWP::Protocol::https 1 ( 1.0.0 )
	echo \>=dev-perl/LWP-Protocol-https-1.0.0
	# LWP::UserAgent
	echo dev-perl/libwww-perl
	# Term::ReadKey
	echo dev-perl/TermReadKey
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
	# Test::More 0.96 ( 0.960.0 )
	echo \>=virtual/perl-Test-Simple-0.96
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
