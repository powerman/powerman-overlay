# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{10..12})

inherit distutils-r1 pypi

DESCRIPTION="A library to create language servers"
HOMEPAGE="https://github.com/neomutt/lsp-tree-sitter https://pypi.org/project/lsp-tree-sitter/"

S=${WORKDIR}/${PN//-/_}-${PV}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/jinja[${PYTHON_USEDEP}]
	dev-python/jsonschema[${PYTHON_USEDEP}]
	dev-python/pygls[${PYTHON_USEDEP}]
	dev-python/tree-sitter[${PYTHON_USEDEP}]
	dev-python/beautifulsoup4[${PYTHON_USEDEP}]
	dev-python/pypandoc[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
