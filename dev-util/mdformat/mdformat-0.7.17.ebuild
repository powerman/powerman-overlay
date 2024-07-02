# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{10..12})

inherit distutils-r1 pypi

DESCRIPTION="CommonMark compliant Markdown formatter"
HOMEPAGE="https://github.com/executablebooks/mdformat https://pypi.org/project/mdformat/"
SRC_URI="$(pypi_sdist_url "${PN//-/_}")"

S=${WORKDIR}/${PN//-/_}-${PV}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/markdown-it-py[${PYTHON_USEDEP}]
	dev-python/tomli[${PYTHON_USEDEP}]
	dev-python/importlib-metadata[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
