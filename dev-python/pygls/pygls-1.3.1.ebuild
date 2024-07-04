# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=(python3_{10..12} pypy3)

inherit distutils-r1 pypi

DESCRIPTION="A pythonic generic language server"
HOMEPAGE="https://github.com/openlawlibrary/pygls https://pypi.org/project/pygls/"
SRC_URI="https://files.pythonhosted.org/packages/source/${PN::1}/${PN}/${P}.tar.gz"

S=${WORKDIR}/${P}

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/cattrs[${PYTHON_USEDEP}]
	dev-python/lsprotocol[${PYTHON_USEDEP}]
	dev-python/websockets[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
