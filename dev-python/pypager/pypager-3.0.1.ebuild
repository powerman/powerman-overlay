# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=(python3_{10..12})

inherit distutils-r1 pypi

DESCRIPTION="A $PAGER in pure Python, similar to less"
HOMEPAGE="https://github.com/prompt-toolkit/pypager https://pypi.org/project/pypager/"

S=${WORKDIR}/${PN//-/_}-${PV}

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/prompt-toolkit[${PYTHON_USEDEP}]
	dev-python/pygments[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
