# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{10..12})
DISTUTILS_EXT=1
DISTUTILS_SINGLE_IMPL=1

CRATES="
	aho-corasick@1.1.3
	autocfg@1.3.0
	bit-set@0.5.3
	bit-vec@0.6.3
	bitflags@2.6.0
	bstr@1.10.0
	cfg-if@1.0.0
	fancy-regex@0.11.0
	heck@0.4.1
	indoc@2.0.5
	libc@0.2.158
	lock_api@0.4.12
	memchr@2.7.4
	memoffset@0.9.1
	once_cell@1.19.0
	parking_lot@0.12.3
	parking_lot_core@0.9.10
	portable-atomic@1.7.0
	proc-macro2@1.0.86
	pyo3@0.20.3
	pyo3-build-config@0.20.3
	pyo3-ffi@0.20.3
	pyo3-macros@0.20.3
	pyo3-macros-backend@0.20.3
	quote@1.0.36
	redox_syscall@0.5.3
	regex@1.10.6
	regex-automata@0.4.7
	regex-syntax@0.8.4
	rustc-hash@1.1.0
	scopeguard@1.2.0
	serde@1.0.208
	serde_derive@1.0.208
	smallvec@1.13.2
	syn@2.0.75
	target-lexicon@0.12.16
	unicode-ident@1.0.12
	unindent@0.2.3
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
"

inherit cargo distutils-r1 pypi

DESCRIPTION="fast BPE tokeniser for use with OpenAI's models"
HOMEPAGE="https://github.com/openai/tiktoken https://pypi.org/project/tiktoken/"
SRC_URI="
	https://github.com/openai/${PN}/archive/refs/tags/${PV}.tar.gz
	-> ${P}.gh.tar.gz
	${CARGO_CRATE_URIS}
"

S=${WORKDIR}/${PN//-/_}-${PV}

LICENSE="Apache-2.0 Apache-2.0-with-LLVM-exceptions MIT Unicode-DFS-2016 Unlicense"
SLOT="0"
KEYWORDS="~amd64"

BDEPEND="
	$(python_gen_cond_dep '
		dev-python/setuptools-rust[${PYTHON_USEDEP}]
	')
"

DEPEND=""
RDEPEND="${DEPEND}"
