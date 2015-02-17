# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5
MODULE_AUTHOR=RJBS
MODULE_VERSION=5.031
inherit perl-module

DESCRIPTION='distribution builder; installer not included!'
LICENSE=" || ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
perl_meta_configure() {
	# ExtUtils::MakeMaker 6.30 ( 6.300.0 )
	echo \>=virtual/perl-ExtUtils-MakeMaker-6.30
	# File::ShareDir::Install 0.03 ( 0.30.0 )
	echo \>=dev-perl/File-ShareDir-Install-0.30.0
}
perl_meta_runtime() {
	# App::Cmd::Command::version
	echo \>=dev-perl/App-Cmd-0.321
	# App::Cmd::Setup 0.309 ( 0.309.0 )
	echo \>=dev-perl/App-Cmd-0.309.0
	# App::Cmd::Tester 0.306 ( 0.306.0 )
	echo \>=dev-perl/App-Cmd-0.306.0
	# App::Cmd::Tester::CaptureExternal
	echo dev-perl/App-Cmd
	# Archive::Tar
	echo virtual/perl-Archive-Tar
	# CPAN::Meta::Converter 2.101550 ( 2.101.550 )
	echo \>=virtual/perl-CPAN-Meta-2.101.550
	# CPAN::Meta::Check
	echo dev-perl/CPAN-Meta-Check
	# CPAN::Meta::Merge
	echo \>=virtual/perl-CPAN-Meta-2.143.240
	# CPAN::Meta::Prereqs 2.120630 ( 2.120.630 )
	echo \>=virtual/perl-CPAN-Meta-2.120.630
	# CPAN::Meta::Requirements 2.121 ( 2.121.0 )
	echo \>=virtual/perl-CPAN-Meta-Requirements-2.121.0
	# CPAN::Meta::Validator 2.101550 ( 2.101.550 )
	echo \>=virtual/perl-CPAN-Meta-2.101.550
	# CPAN::Uploader 0.103004 ( 0.103.4 )
	echo \>=dev-perl/CPAN-Uploader-0.103.4
	# Carp
	# echo virtual/perl-Carp
	# Class::Load 0.17 ( 0.170.0 )
	echo \>=dev-perl/Class-Load-0.170.0
	# Config::INI::Reader
	echo dev-perl/Config-INI
	# Config::MVP::Assembler
	echo dev-perl/Config-MVP
	# Config::MVP::Assembler::WithBundles
	echo dev-perl/Config-MVP
	# Config::MVP::Reader 2.101540 ( 2.101.540 )
	echo \>=dev-perl/Config-MVP-2.101.540
	# Config::MVP::Reader::Findable::ByExtension
	echo dev-perl/Config-MVP
	# Config::MVP::Reader::Finder
	echo dev-perl/Config-MVP
	# Config::MVP::Reader::INI 2 ( 2.0.0 )
	echo \>=dev-perl/Config-MVP-Reader-INI-2.0.0
	# Config::MVP::Section 2.200002 ( 2.200.2 )
	echo \>=dev-perl/Config-MVP-2.200.2
	# Data::Dumper
	echo virtual/perl-Data-Dumper
	# Data::Section 0.200002 ( 0.200.2 )
	echo \>=dev-perl/Data-Section-0.200.2
	# DateTime 0.44 ( 0.440.0 )
	echo \>=dev-perl/DateTime-0.440.0
	# Digest::MD5
	echo virtual/perl-Digest-MD5
	# Encode
	echo virtual/perl-Encode
	# ExtUtils::Manifest 1.66 ( 1.660.0 )
	echo \>=virtual/perl-ExtUtils-Manifest-1.660.0
	# File::Copy::Recursive
	echo dev-perl/File-Copy-Recursive
	# File::Find::Rule
	echo dev-perl/File-Find-Rule
	# File::HomeDir
	echo dev-perl/File-HomeDir
	# File::Path
	echo virtual/perl-File-Path
	# File::ShareDir
	echo dev-perl/File-ShareDir
	# File::ShareDir::Install 0.03 ( 0.30.0 )
	echo \>=dev-perl/File-ShareDir-Install-0.30.0
	# File::Spec
	echo virtual/perl-File-Spec
	# File::Temp
	echo virtual/perl-File-Temp
	# File::pushd
	echo dev-perl/File-pushd
	# JSON::MaybeXS
	echo dev-perl/JSON-MaybeXS
	# List::MoreUtils
	echo dev-perl/List-MoreUtils
	# List::Util
	echo virtual/perl-Scalar-List-Utils
	# Log::Dispatchouli 1.102220 ( 1.102.220 )
	echo \>=dev-perl/Log-Dispatchouli-1.102.220
	# Mixin::Linewise::Readers 0.100 ( 0.100.0 )
	echo \>=dev-perl/Mixin-Linewise-0.100.0
	# Module::CoreList
	echo perl-core/Module-CoreList
	# Moose 0.92 ( 0.920.0 )
	echo \>=dev-perl/Moose-0.920.0
	# Moose::Role
	echo dev-perl/Moose
	# Moose::Util::TypeConstraints
	echo dev-perl/Moose
	# MooseX::LazyRequire
	echo dev-perl/MooseX-LazyRequire
	# MooseX::Role::Parameterized
	echo dev-perl/MooseX-Role-Parameterized
	# MooseX::SetOnce
	echo dev-perl/MooseX-SetOnce
	# MooseX::Types
	echo dev-perl/MooseX-Types
	# MooseX::Types::Moose
	echo dev-perl/MooseX-Types
	# MooseX::Types::Path::Class
	echo dev-perl/MooseX-Types-Path-Class
	# MooseX::Types::Perl
	echo dev-perl/MooseX-Types-Perl
	# PPI::Document
	echo dev-perl/PPI
	# Params::Util
	echo dev-perl/Params-Util
	# Path::Class 0.22 ( 0.220.0 )
	echo \>=dev-perl/Path-Class-0.220.0
	# Path::Tiny
	echo dev-perl/Path-Tiny
	# Perl::PrereqScanner 1.016 ( 1.16.0 )
	echo \>=dev-perl/Perl-PrereqScanner-1.16.0
	# Perl::Version
	echo dev-perl/Perl-Version
	# Pod::Eventual 0.091480 ( 0.91.480 )
	echo \>=dev-perl/Pod-Eventual-0.91.480
	# Scalar::Util
	echo virtual/perl-Scalar-List-Utils
	# Software::License 0.101370 ( 0.101.370 )
	echo \>=dev-perl/Software-License-0.101.370
	# Software::LicenseUtils
	echo dev-perl/Software-License
	# Storable
	echo virtual/perl-Storable
	# String::Formatter 0.100680 ( 0.100.680 )
	echo \>=dev-perl/String-Formatter-0.100.680
	# String::RewritePrefix 0.005 ( 0.5.0 )
	echo \>=dev-perl/String-RewritePrefix-0.5.0
	# Sub::Exporter
	echo dev-perl/Sub-Exporter
	# Sub::Exporter::ForMethods
	echo dev-perl/Sub-Exporter-ForMethods
	# Sub::Exporter::Util
	echo dev-perl/Sub-Exporter
	# Term::Encoding
	echo dev-perl/Term-Encoding
	# Term::ReadKey
	echo dev-perl/TermReadKey
	# Term::ReadLine
	# echo dev-perl/Term-ReadLine
	# Term::UI
	echo dev-perl/Term-UI
	# Test::Deep
	echo dev-perl/Test-Deep
	# Text::Glob 0.08 ( 0.80.0 )
	echo \>=dev-perl/Text-Glob-0.80.0
	# Text::Template
	echo dev-perl/text-template
	# Try::Tiny
	echo dev-perl/Try-Tiny
	# YAML::Tiny
	echo dev-perl/YAML-Tiny
	# autodie
	echo virtual/perl-autodie
	# namespace::autoclean
	echo dev-perl/namespace-autoclean
	# parent
	echo virtual/perl-parent
	# perl v5.8.5 ( 5.8.5 )
	echo \>=dev-lang/perl-5.8.5
	# strict
	echo dev-lang/perl
	# version
	echo virtual/perl-version
	# warnings
	echo dev-lang/perl
}
perl_meta_test() {
	# ExtUtils::MakeMaker
	echo virtual/perl-ExtUtils-MakeMaker
	# File::Spec::Functions
	echo virtual/perl-File-Spec
	# Software::License::None
	echo dev-perl/Software-License
	# Test::FailWarnings
	echo dev-perl/Test-FailWarnings
	# Test::Fatal
	echo dev-perl/Test-Fatal
	# Test::File::ShareDir
	echo dev-perl/Test-File-ShareDir
	# Test::More 0.96 ( 0.960.0 )
	echo \>=virtual/perl-Test-Simple-0.96
	# lib
	# echo virtual/perl-lib
	# utf8
	# echo dev-lang/perl
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
