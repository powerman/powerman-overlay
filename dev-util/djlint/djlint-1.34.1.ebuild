# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=(python3_{10..12})

inherit distutils-r1 pypi

DESCRIPTION="HTML Template Linter and Formatter"
HOMEPAGE="https://github.com/djlint/djLint https://pypi.org/project/djlint/"
SRC_URI="$(pypi_sdist_url "${PN//-/_}")"

S=${WORKDIR}/${PN//-/_}-${PV}

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/colorama[${PYTHON_USEDEP}]
	dev-python/cssbeautifier[${PYTHON_USEDEP}]
	dev-python/html-tag-names[${PYTHON_USEDEP}]
	dev-python/html-void-elements[${PYTHON_USEDEP}]
	dev-python/jsbeautifier[${PYTHON_USEDEP}]
	dev-python/json5[${PYTHON_USEDEP}]
	dev-python/pathspec[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	dev-python/regex[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
