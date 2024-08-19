# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=maturin
PYTHON_COMPAT=(python3_{10..12})
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=1

CRATES="
	ahash@0.8.11
	arbitrary@1.3.2
	autocfg@1.3.0
	bencher@0.1.5
	bitvec@1.0.1
	cc@1.1.13
	cfg-if@1.0.0
	codspeed@2.6.0
	codspeed-bencher-compat@2.6.0
	colored@2.1.0
	equivalent@1.0.1
	funty@2.0.0
	getrandom@0.2.15
	hashbrown@0.14.5
	heck@0.5.0
	indexmap@2.4.0
	indoc@2.0.5
	itoa@1.0.11
	jobserver@0.1.32
	lazy_static@1.5.0
	lexical-parse-float@0.8.5
	lexical-parse-integer@0.8.6
	lexical-util@0.8.5
	libc@0.2.158
	libfuzzer-sys@0.4.7
	memchr@2.7.4
	memoffset@0.9.1
	num-bigint@0.4.6
	num-integer@0.1.46
	num-traits@0.2.19
	once_cell@1.19.0
	paste@1.0.15
	portable-atomic@1.7.0
	proc-macro2@1.0.86
	pyo3@0.22.2
	pyo3-build-config@0.22.2
	pyo3-ffi@0.22.2
	pyo3-macros@0.22.2
	pyo3-macros-backend@0.22.2
	quote@1.0.36
	radium@0.7.0
	ryu@1.0.18
	serde@1.0.208
	serde_derive@1.0.208
	serde_json@1.0.125
	shlex@1.3.0
	smallvec@1.13.2
	static_assertions@1.1.0
	syn@2.0.75
	tap@1.0.1
	target-lexicon@0.12.16
	unicode-ident@1.0.12
	unindent@0.2.3
	version_check@0.9.5
	wasi@0.11.0+wasi-snapshot-preview1
	windows_aarch64_gnullvm@0.48.5
	windows_aarch64_msvc@0.48.5
	windows_i686_gnu@0.48.5
	windows_i686_msvc@0.48.5
	windows-sys@0.48.0
	windows-targets@0.48.5
	windows_x86_64_gnu@0.48.5
	windows_x86_64_gnullvm@0.48.5
	windows_x86_64_msvc@0.48.5
	wyz@0.5.1
	zerocopy@0.7.35
	zerocopy-derive@0.7.35
"

inherit cargo distutils-r1 pypi

DESCRIPTION="Fast iterable JSON parser"
HOMEPAGE="https://github.com/pydantic/jiter https://pypi.org/project/jiter/"
SRC_URI="
	https://github.com/pydantic/${PN}/archive/refs/tags/v${PV}.tar.gz
	-> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

S=${WORKDIR}/${PN//-/_}-${PV}/crates/jiter-python

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions BSD-2 Boost-1.0 MIT MPL-2.0 Unicode-DFS-2016 Unlicense"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	$(python_gen_cond_dep '
		dev-python/setuptools-rust[${PYTHON_USEDEP}]
	')
"

DEPEND="
	$(python_gen_cond_dep '
		dev-util/maturin
		dev-python/orjson[${PYTHON_USEDEP}]
		dev-python/ujson[${PYTHON_USEDEP}]
	')
"
RDEPEND="${DEPEND}"
