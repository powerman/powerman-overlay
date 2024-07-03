# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=(python3_{10..12})

inherit distutils-r1 pypi

DESCRIPTION="Mdformat plugin for GitHub Flavored Markdown compatibility"
HOMEPAGE="https://github.com/executablebooks/mdformat-gfm https://pypi.org/project/mdformat-gfm/"
SRC_URI="$(pypi_sdist_url "${PN//-/_}")"

S=${WORKDIR}/${PN//-/_}-${PV}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-util/mdformat[${PYTHON_USEDEP}]
	dev-python/markdown-it-py[${PYTHON_USEDEP}]
	dev-python/mdit-py-plugins[${PYTHON_USEDEP}]
	dev-python/mdformat-tables[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
