# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=(python3_{10..12})

inherit distutils-r1 pypi

DESCRIPTION="mdformat plugin to render thematic breaks using three dashes"
HOMEPAGE="https://github.com/csala/mdformat-simple-breaks https://pypi.org/project/mdformat_simple_breaks/"
SRC_URI="$(pypi_sdist_url "${PN//-/_}")"

S=${WORKDIR}/${PN//-/_}-${PV}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-util/mdformat[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
