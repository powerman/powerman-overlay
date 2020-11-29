# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="Show info about the current working directory for various VCS for PS1"
HOMEPAGE="https://github.com/powerman/vcprompt"
SRC_URI="https://github.com/powerman/vcprompt/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_prepare() {
	default
	eautoconf
}

src_install() {
	dobin vcprompt
	dobin vcprompt-hgst
	doman vcprompt.1
	einstalldocs
}
