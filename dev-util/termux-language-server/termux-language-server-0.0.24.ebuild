# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{10..12})

inherit distutils-r1 pypi

DESCRIPTION="A language server for some specific bash scripts"
HOMEPAGE="https://github.com/termux/termux-language-server https://pypi.org/project/termux-language-server/"
SRC_URI="$(pypi_sdist_url "${PN//-/_}")"

S=${WORKDIR}/${PN//-/_}-${PV}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/fqdn[${PYTHON_USEDEP}]
	dev-python/lsp-tree-sitter[${PYTHON_USEDEP}]
	dev-python/platformdirs[${PYTHON_USEDEP}]
	dev-python/rfc3987[${PYTHON_USEDEP}]
	dev-libs/tree-sitter-bash[${PYTHON_USEDEP}]
	dev-python/license-expression[${PYTHON_USEDEP}]
	>=dev-python/tree-sitter-0.22.0[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
