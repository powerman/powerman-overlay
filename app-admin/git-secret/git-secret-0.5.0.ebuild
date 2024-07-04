# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A bash-tool to store your private data inside a git repository"
HOMEPAGE="https://github.com/sobolevn/git-secret"
SRC_URI="https://github.com/sobolevn/git-secret/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="${DEPEND}"
