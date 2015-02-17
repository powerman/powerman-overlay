# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
MODULE_AUTHOR=RTHOMPSON
MODULE_VERSION=0.150250
inherit perl-module

DESCRIPTION='Automatically convert POD to a README in any format for Dist::Zilla'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
perl_meta_configure() {
	# ExtUtils::MakeMaker 6.30 ( 6.300.0 )
	echo \>=virtual/perl-ExtUtils-MakeMaker-6.30
}
perl_meta_build() {
	# Carp
	echo dev-lang/perl
	# Dist-Zilla-Role-File-ChangeNotification
	echo dev-perl/Dist-Zilla-Role-File-ChangeNotification
	# Dist::Zilla::Role::PluginBundle::Easy
	echo dev-perl/Dist-Zilla
	# English
	echo dev-lang/perl
	# File::Find
	echo dev-lang/perl
	# File::Temp
	echo virtual/perl-File-Temp
	# Scalar::Util
	echo virtual/perl-Scalar-List-Utils
	# Test::DZil
	echo dev-perl/Dist-Zilla
	# Test::More 0.94 ( 0.940.0 )
	echo \>=virtual/perl-Test-Simple-0.94
	# Test::Most
	echo dev-perl/Test-Most
	# autodie
	echo virtual/perl-autodie
	# perl 5.004 ( 5.4.0 )
	echo \>=dev-lang/perl-5.4.0
	# utf8
	echo dev-lang/perl
}
perl_meta_runtime() {
	# Dist::Zilla::File::InMemory
	echo dev-perl/Dist-Zilla
	# Dist::Zilla::Role::FilePruner
	echo dev-perl/Dist-Zilla
	# Dist::Zilla::Role::InstallTool
	echo dev-perl/Dist-Zilla
	# Encode
	echo virtual/perl-Encode
	# File::Slurp
	echo dev-perl/File-Slurp
	# IO::Handle
	echo virtual/perl-IO
	# IO::Scalar
	echo dev-perl/IO-stringy
	# Moose
	echo dev-perl/Moose
	# Moose::Autobox
	echo dev-perl/Moose-Autobox
	# Moose::Util::TypeConstraints
	echo dev-perl/Moose
	# MooseX::Has::Sugar
	echo dev-perl/MooseX-Has-Sugar
	# Pod::Markdown
	echo \>=dev-perl/Pod-Markdown-2.000
	# Pod::Select
	echo virtual/perl-Pod-Parser
	# Pod::Simple::HTML
	echo virtual/perl-Pod-Simple
	# Pod::Text
	echo virtual/perl-podlators
	# perl 5.008 ( 5.8.0 )
	echo \>=dev-lang/perl-5.8.0
	# strict
	echo dev-lang/perl
	# warnings
	echo dev-lang/perl
}
DEPEND="
	$(perl_meta_configure)
	$(perl_meta_build)
	$(perl_meta_runtime)
"
RDEPEND="
	$(perl_meta_runtime)
"
SRC_TEST="do"
