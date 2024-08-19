# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{10..12})

inherit distutils-r1 pypi

DESCRIPTION="Grep source code and see useful code context about matching lines"
HOMEPAGE="https://github.com/paul-gauthier/grep-ast https://pypi.org/project/grep-ast/"

S=${WORKDIR}/${PN//-/_}-${PV}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/tree-sitter-languages[${PYTHON_USEDEP}]
	dev-python/pathspec[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
