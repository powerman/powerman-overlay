# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
MODULE_AUTHOR=RJBS
MODULE_VERSION=2.200008
inherit perl-module

DESCRIPTION='multivalue-property package-oriented configuration'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
perl_meta_configure() {
	# ExtUtils::MakeMaker 6.30 ( 6.300.0 )
	echo \>=virtual/perl-ExtUtils-MakeMaker-6.30
}
perl_meta_runtime() {
	# Class::Load 0.17 ( 0.170.0 )
	echo \>=dev-perl/Class-Load-0.170.0
	# File::Spec
	echo virtual/perl-File-Spec
	# Module::Pluggable::Object
	echo virtual/perl-Module-Pluggable
	# Module::Runtime
	echo dev-perl/Module-Runtime
	# Moose 0.91 ( 0.910.0 )
	echo \>=dev-perl/Moose-0.910.0
	# Moose::Role
	echo dev-perl/Moose
	# Moose::Util::TypeConstraints
	echo dev-perl/Moose
	# MooseX::OneArgNew
	echo dev-perl/MooseX-OneArgNew
	# Params::Util
	echo dev-perl/Params-Util
	# Role::HasMessage
	echo dev-perl/Role-HasMessage
	# Role::Identifiable::HasIdent
	echo dev-perl/Role-Identifiable
	# StackTrace::Auto
	echo dev-perl/Throwable
	# Test::More 0.88 ( 0.880.0 )
	echo \>=virtual/perl-Test-Simple-0.88
	# Throwable
	echo dev-perl/Throwable
	# Tie::IxHash
	echo dev-perl/Tie-IxHash
	# Try::Tiny
	echo dev-perl/Try-Tiny
	# overload
	echo dev-lang/perl
	# strict
	echo dev-lang/perl
	# warnings
	echo dev-lang/perl
}
perl_meta_test() {
	# Capture::Tiny
	echo dev-perl/Capture-Tiny
	# Test::Fatal
	echo dev-perl/Test-Fatal
	# Test::More 0.96 ( 0.960.0 )
	echo \>=virtual/perl-Test-Simple-0.96
	# blib
	# echo dev-lang/perl
	# lib
	# echo dev-perl/lib
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
